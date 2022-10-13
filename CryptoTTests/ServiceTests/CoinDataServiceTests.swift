//
//  CoinDataServiceTests.swift
//  CryptoTTests
//
//  Created by Pierre on 26/09/2022.
//

import XCTest
@testable import CryptoT
import Combine

final class CoinDataServiceTests: XCTestCase {
    // custom urlsession for mock network calls
    var urlSession: URLSession!
    var store: Set<AnyCancellable> = .init()
    
    override func setUpWithError() throws {
        // Set url session for mock networking
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        urlSession = URLSession(configuration: configuration)
    }
    
    func testGetCoins() throws {
        // CoinDataService. Injected with custom url session for mocking
        let coinDataService = CoinDataService(urlSession: urlSession)
        
        // Set mock data
        let mockCoins = [Coin(id: "Sample", symbol: "Sample", name: "Sample", image: "Sample", currentPrice: 0, marketCap: 0, marketCapRank: 0, fullyDilutedValuation: 0, totalVolume: 0, high24H: 0, low24H: 0, priceChange24H: 0, priceChangePercentage24H: 0, marketCapChange24H: 0, marketCapChangePercentage24H: 0, circulatingSupply: 0, totalSupply: 0, maxSupply: 0, ath: 0, athChangePercentage: 0, athDate: "Sample", atl: 0, atlChangePercentage: 0, atlDate: "Sample", lastUpdated: "Sample", sparklineIn7D: nil, priceChangePercentage24HInCurrency: 0, currentHoldings: 0)]
        let mockData = try JSONEncoder().encode(mockCoins)
        
        // Return data in mock request handler
        MockURLProtocol.requestHandler = { request in
            return (HTTPURLResponse(url: URL(string: "www.google.com")!, statusCode: 200, httpVersion: nil, headerFields: nil), mockData)
        }
        
        // Set expectation. Used to test async code.
        let expectation = XCTestExpectation(description: "response")
        
        // Make mock network request to get coins
        coinDataService.getCoins()
        
//        coinDataService.getCoins { coins in
//            // Test
//            XCTAssertEqual(coins[0].name, "Sample")
//            expectation.fulfill()
//        }
        //wait(for: [expectation], timeout: 1)
        
    }
}


