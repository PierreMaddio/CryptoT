//
//  HomeViewModel.swift
//  CryptoT
//
//  Created by Pierre on 09/09/2022.
//

import Foundation
import Combine

/*
 ObservableObject: observed it from our view
 Our view has a reference to this HomeViewModel, this viewModel has a dataService witch initialise a CoinDataService(init getCoins), this getCoins func go to the url, download the data, check if it is valid data, decode that data and then take that data and append to allCoins array.Because allCoins is @Published, in HomeViewModel(init addSubscribers), func addSubscribers subscribing that $allCoins array(Published variable), then append to our allCoins array of HomeViewModel(same name allCoins)
 */
class HomeViewModel: ObservableObject {
    
    @Published var statistics: [Statistic] = []
    
    @Published var allCoins: [Coin] = []
    @Published var portfolioCoins: [Coin] = []
    @Published var isLoading: Bool = false
    
    // anything subscribed to the this publisher will then receive that new value
    @Published var searchText: String = ""
    
    // dataService initialize CoinDataService(), with init() get the coin utomatically
    private let coinDataService = CoinDataService()
    private let marketDataService = MarketDataService()
    private let portfolioDataService = PortfolioDataService()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        
        // updates allCoins
        $searchText
            .combineLatest(coinDataService.$allCoins)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterCoins)
            .sink { [weak self] (returnedCoins) in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables)
        
        // updates portfolio
        $allCoins
            .combineLatest(portfolioDataService.$savedEntities)
            .map(mapAllCoinsToPortfolioCoins) // the parameters are the same as the subscribers
            .sink { [weak self] (returnedCoins) in
                self?.portfolioCoins = returnedCoins
            }
            .store(in: &cancellables)
        
        // updates marketData
        marketDataService.$marketData
            .combineLatest($portfolioCoins)
            .map(markGlobalMarketData)
            .sink { [weak self] (returnedStats) in
                self?.statistics = returnedStats
                self?.isLoading = false
            }
            .store(in: &cancellables)
    }
    
    func updatePortfolio(coin: Coin, amount: Double) {
        portfolioDataService.updatePortfolio(coin: coin, amount: amount)
    }
    
    func reloadData() {
        isLoading = true
        coinDataService.getCoins()
        marketDataService.getData()
        // device vibration
        HapticManager.notification(type: .success)
    }
    
    private func filterCoins(text: String, coins: [Coin]) -> [Coin] {
        guard !text.isEmpty else {
            return coins
        }
        
        let lowercasedText = text.lowercased()
        
        return coins.filter { (coin) -> Bool in
            return coin.name.lowercased().contains(lowercasedText) || coin.symbol.lowercased().contains(lowercasedText) || coin.id.lowercased().contains(lowercasedText)
        }
    }
    
    private func mapAllCoinsToPortfolioCoins(allCoins: [Coin], portfolioEntities: [PortfolioEntity]) -> [Coin] {
        allCoins
            .compactMap { (coin) -> Coin? in
                guard let entity = portfolioEntities.first(where: { $0.coinID == coin.id }) else {
                    return nil
                }
                return coin.updateHoldings(amount: entity.amount)
            }
    }
    
    
    private func markGlobalMarketData(marketDataModel: MarketData?, portfolioCoins: [Coin]) -> [Statistic] {
        var stats: [Statistic] = []
        
        guard let data = marketDataModel else {
            return stats
        }
        
        let marketCap = Statistic(title: "Market Cap", value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUsd)
        let volume = Statistic(title: "24h Volume", value: data.volume)
        let btcDominance = Statistic(title: "BTC Dominance", value: data.btcDominance)
        
        let portfolioValue =
            portfolioCoins
                .map({ $0.currentHoldingsValue })
                .reduce(0, +)
        
        let previousValue =
            portfolioCoins
                .map { (coin) -> Double in
                    let currentValue = coin.currentHoldingsValue
                    let percenChange = (coin.priceChangePercentage24H ?? 0)  / 100
                    let previousValue = currentValue / (1 + percenChange)
                    return previousValue
                }
                .reduce(0, +)
    
        let percentageChange = ((portfolioValue - previousValue) / previousValue) * 100
        
        let portfolio = Statistic(
            title: "Portfolio Value",
            value: portfolioValue.asCurrencyWith2Decimals(),
            percentageChange: percentageChange)
        
        stats.append(contentsOf: [
            marketCap,
            volume,
            btcDominance,
            portfolio
        ])
        return stats

    }
    
}
