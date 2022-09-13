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
    
    @Published var statistics: [Statistic] = [
        Statistic(title: "Title", value: "Value", percentageChange: 1),
        Statistic(title: "Title", value: "Value"),
        Statistic(title: "Title", value: "Value"),
        Statistic(title: "Title", value: "Value", percentageChange: -7)
    ]
    
    @Published var allCoins: [Coin] = []
    @Published var portfolioCoins: [Coin] = []
    
    // anything subscribed to the this publisher will then receive that new value
    @Published var searchText: String = ""
    
    // dataService initialize CoinDataService(), with init() get the coin utomatically
    private let dataService = CoinDataService()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        
        // updates allCoins
        $searchText
            .combineLatest(dataService.$allCoins)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterCoins)
            .sink { [weak self] (returnedCoins) in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables)
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
    
}
