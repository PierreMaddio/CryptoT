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
 Our view has a reference to this HomeViewModel, this viewModel has a dataService witch initialise a CoinDataService(init getCoins), this getCoins func go to the url, download the data, check is it is valid data, decode that data and then take that data and append to allCoins array.Because allCoins is @Published, in HomeViewModel(init addSubscribers), func addSubscribers subscribing that $allCoins array(Published variable), then append to our allCoins array of HomeViewModel(same name allCoins)
 */
class HomeViewModel: ObservableObject {
    
    @Published var allCoins: [Coin] = []
    @Published var portfolioCoins: [Coin] = []
    
    // dataService initialize CoinDataService(), with init() get the coin utomatically
    private let dataService = CoinDataService()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        // $allCoins is the publisher from CoinDataService
        dataService.$allCoins
            .sink { [weak self] (returnedCoins) in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables)
    }
    
}
