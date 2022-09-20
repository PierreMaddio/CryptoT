//
//  CoinDetailDataService.swift
//  CryptoT
//
//  Created by Pierre on 14/09/2022.
//

import Foundation
import Combine

protocol CoinDetailDataServiceProtocol {
    func getCoinDetails()
    // In order to make CoinDataServiceProtocol have a published value for allCoins, we use the ObservableValue wrapper to wrap a CoinDetail.
    var coinDetails: ObservableValue<CoinDetail?> { get set }
}

class CoinDetailDataService: CoinDetailDataServiceProtocol {
    var coinDetails: ObservableValue<CoinDetail?> = .init(nil)
    
    var coinDetailSubscription: AnyCancellable?
    let coin: Coin
    
    init(coin: Coin) {
        self.coin = coin
        getCoinDetails()
    }
    
    func getCoinDetails() {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/\(coin.id)?localization=false&tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=false") else { return }
        
        coinDetailSubscription = URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { (output) -> Data in
                guard let response = output.response as? HTTPURLResponse,
                      response.statusCode >= 200 && response.statusCode < 300 else {
                    throw URLError(.badServerResponse)
                }
                return output.data
            }
            .decode(type: CoinDetail.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { (completion) in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { [weak self] (returnedCoinDetails) in
                self?.coinDetails.value = returnedCoinDetails
                self?.coinDetailSubscription?.cancel()
            }
    }
}

/*
class CoinDetailDataService: CoinDetailDataServiceProtocol {
    var coinDetails: ObservableValue<CoinDetail?> = .init(nil)
    
    var coinDetailSubscription: AnyCancellable?
    let coin: Coin
    
    init(coin: Coin) {
        self.coin = coin
        getCoinDetails()
    }
    
    func getCoinDetails() {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/\(coin.id)?localization=false&tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=false") else { return }
        
        coinDetailSubscription = NetworkingManager.download(url: url)
            .decode(type: CoinDetail.self, decoder: JSONDecoder()) // background thread to decode
            .receive(on: DispatchQueue.main) // back to main thread before sink
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedCoinDetails) in
                self?.coinDetails.value = returnedCoinDetails
                self?.coinDetailSubscription?.cancel()
            })
    }
}
*/
