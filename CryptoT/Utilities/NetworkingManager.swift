//
//  NetworkingManager.swift
//  CryptoT
//
//  Created by Pierre on 11/09/2022.
//

import Foundation
import Combine

class NetworkingManager {
    enum NetworkingError: LocalizedError {
        case badURLResponse(url: URL)
        case unknown
        
        var errorDescription: String? {
            switch self {
            case .badURLResponse(url: let url): return "[🔥] Bad response from URL: \(url)"
                
            case .unknown: return "[⚠️] Unknown error occured"
            }
        }
    }
    /// func download
    /// creating a dataTaskPublisher
    /// and automatically going on to a background thread,
    /// handle the response using func handleURLResponse,
    /// mapping the response making sure we have good data,
    /// and returning as any publisher
    static func download(url: URL) -> AnyPublisher<Data, Error> {
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap({ try handleURLResponse(output: $0, url: url) })
            .eraseToAnyPublisher()
    }
    
    static func handleURLResponse(output: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
            throw NetworkingError.badURLResponse(url: url)
        }
        return output.data
    }
    
    static func handleCompletion(completion: Subscribers.Completion<Error>) {
        switch completion {
        case.finished:
            break
        case.failure(let error):
            print(error.localizedDescription)
        }
    }
}
