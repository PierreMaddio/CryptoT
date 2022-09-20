//
//  CoinDataService.swift
//  CryptoT
//
//  Created by Pierre on 10/09/2022.
//

import Foundation
import Combine

protocol CoinDataServiceProtocol {
    func getCoins()
    var allCoins: ObservableValue<[Coin]> { get set }
}

class CoinDataService: CoinDataServiceProtocol {
    var allCoins: ObservableValue<[Coin]> = .init([])
    var coinSubscription: AnyCancellable?
    
    init() {
        getCoins()
    }
    
    func getCoins() {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h") else { return }
        
        coinSubscription = URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { (output) -> Data in
                guard let response = output.response as? HTTPURLResponse,
                      response.statusCode >= 200 && response.statusCode < 300 else {
                    throw URLError(.badServerResponse)
                }
                return output.data
            }
            .decode(type: [Coin].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { (completion) in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { [weak self] (returnedCoins) in
                self?.allCoins.value = returnedCoins
                self?.coinSubscription?.cancel()
            }
    }
}

/*
class CoinDataService: CoinDataServiceProtocol {
    var allCoins: ObservableValue<[Coin]> = .init([])
    var coinSubscription: AnyCancellable?
    
    init() {
        getCoins()
    }
    
    /// When we initialize a CoinDataService, it is going to initialize and call getCoins().
    /// The getCoins() func is going to get the url,
    /// get the data from the url,
    /// check for a valid good response,
    /// if we get data, it is going to try to decode it into [Coin]
    /// and append the returnedCoins to our allCoins array.
    func getCoins() {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h") else { return }
        
        coinSubscription = NetworkingManager.download(url: url)
            .decode(type: [Coin].self, decoder: JSONDecoder()) // background thread to decode(download)
            .receive(on: DispatchQueue.main) // back to main thread before sink
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedCoins) in
                self?.allCoins.value = returnedCoins
                self?.coinSubscription?.cancel()
            })
    }
}
*/
