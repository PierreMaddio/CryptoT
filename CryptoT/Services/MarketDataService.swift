//
//  MarketDataService.swift
//  CryptoT
//
//  Created by Pierre on 13/09/2022.
//

import Foundation
import Combine

protocol MarketDataServiceProtocol {
    func getData()
    var marketData: ObservableValue<MarketData?> { get set }
}

class MarketDataService: MarketDataServiceProtocol {
    var marketData: ObservableValue<MarketData?> = .init(nil)
    var marketDataSubscription: AnyCancellable?
    
    init() {
        getData()
    }
    
    func getData() {
        // api coingecko: coins, coins/markets: usd, market_cap_desc, 250 results, 1, sparkline(true), 24h price change)
        guard let url = URL(string: "https://api.coingecko.com/api/v3/global"
        ) else { return }
        
        marketDataSubscription = URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { (output) -> Data in
                guard let response = output.response as? HTTPURLResponse,
                      response.statusCode >= 200 && response.statusCode < 300 else {
                    throw URLError(.badServerResponse)
                }
                return output.data
            }
            .decode(type: MarketData.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { (completion) in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { [weak self] (returnedGlobalData) in
                self?.marketData.value = returnedGlobalData
                self?.marketDataSubscription?.cancel()
            }
    }
}

/*
 class MarketDataService: MarketDataServiceProtocol {
 var marketData: ObservableValue<MarketData?> = .init(nil)
 var marketDataSubscription: AnyCancellable?
 
 init() {
 getData()
 }
 
 func getData() {
 // api coingecko: coins, coins/markets: usd, market_cap_desc, 250 results, 1, sparkline(true), 24h price change)
 guard let url = URL(string: "https://api.coingecko.com/api/v3/global"
 ) else { return }
 
 marketDataSubscription = NetworkingManager.download(url: url)
 .decode(type: GlobalData.self, decoder: JSONDecoder()) // background thread to decode
 .receive(on: DispatchQueue.main) // back to main thread before sink
 .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedGlobalData) in
 self?.marketData.value = returnedGlobalData.data
 self?.marketDataSubscription?.cancel()
 })
 }
 }
 */
