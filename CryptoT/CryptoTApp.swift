//
//  CryptoTApp.swift
//  CryptoT
//
//  Created by Pierre on 02/09/2022.
//

import SwiftUI

@main
struct CryptoTApp: App {
    // anything in the HomeView has access to the HomeViewModel
    @StateObject private var vm = HomeViewModel()
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor : UIColor(Color.theme.accent)]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor : UIColor(Color.theme.accent)]
    }
    
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
