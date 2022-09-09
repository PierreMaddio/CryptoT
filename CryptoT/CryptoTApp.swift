//
//  CryptoTApp.swift
//  CryptoT
//
//  Created by Pierre on 02/09/2022.
//

import SwiftUI

@main
struct CryptoTApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeView()
                    .navigationBarHidden(true)
            }
        }
    }
}
