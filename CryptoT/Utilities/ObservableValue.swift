//
//  ObservableValue.swift
//  CryptoT
//
//  Created by Pierre on 20/09/2022.
//

import Foundation

class ObservableValue<T> {
    @Published var value: T
    init(_ value: T) {
        self.value = value
    }
}

