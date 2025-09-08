//
//  SWAPIApp.swift
//  SWAPI
//
//  Created by Nilusha Niwanthaka Wimalasena on 8/9/25.
//

import SwiftUI

@main
struct CryptoPricesApp: App {

    @StateObject private var coordinator = AppCoordinator()
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                NavigationStack(path: $coordinator.path) {
                    coordinator.buildInitialView()
                        .navigationDestination(for: Routes.self) { route in
                            coordinator.buildDestination(for: route)
                        }
                }
                .environmentObject(coordinator)
            }
        }
    }
}
