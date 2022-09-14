//
//  UIApplication.swift
//  CryptoT
//
//  Created by Pierre on 12/09/2022.
//

import Foundation
import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
