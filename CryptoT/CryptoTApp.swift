//
//  CryptoTApp.swift
//  CryptoT
//
//  Created by Pierre on 02/09/2022.
//

import SwiftUI

@main
struct CryptoTApp: App {
    // anything in the HomeView as access to the HomeViewModel
    @StateObject private var vm = HomeViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeView()
                    .navigationBarHidden(true)
            }
            .environmentObject(vm)
        }
    }
}
