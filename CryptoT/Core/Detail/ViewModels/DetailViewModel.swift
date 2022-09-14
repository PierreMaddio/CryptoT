//
//  DetailViewModel.swift
//  CryptoT
//
//  Created by Pierre on 14/09/2022.
//

import Foundation
import Combine

class DetailViewModel: ObservableObject {
    private let coinDetailService: CoinDetailDataService
    private var cancellables = Set<AnyCancellable>()
    
    init(coin: Coin) {
        self.coinDetailService = CoinDetailDataService(coin: coin)
        self.addSubscribers()
    }
    
    private func addSubscribers() {
        coinDetailService.$coinDetails
            .sink { (returnedCoinDetails) in
                print("received coin detail")
                print(returnedCoinDetails)
            }
            .store(in: &cancellables)
    }
}
