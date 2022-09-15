//
//  String.swift
//  CryptoT
//
//  Created by Pierre on 15/09/2022.
//

import Foundation

extension String {
    var removingHTMLOccurances: String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
}
