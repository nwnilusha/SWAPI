//
//  SWAPIApp.swift
//  SWAPI
//
//  Created by Nilusha Niwanthaka Wimalasena on 8/9/25.
//

import SwiftUI

@main
struct CryptoPricesApp: App {
    
    @AppStorage("selectedTheme") private var selectedTheme: String = "system"
    @StateObject private var coordinator = AppCoordinator()
    @StateObject private var networkMonitor = NetworkMonitor()
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                if coordinator.showSplashScreen {
                    coordinator.buildSplashScreen()
                        .environmentObject(coordinator)
                        .transition(.opacity)
                        .zIndex(2)
                } else {
                    NavigationStack(path: $coordinator.path) {
                        coordinator.buildInitialView()
                            .navigationDestination(for: Routes.self) { route in
                                coordinator.buildDestination(for: route)
                            }
                    }
                    .environmentObject(coordinator)
                    .environmentObject(networkMonitor)
                    .preferredColorScheme(ThemeManager.currentColorScheme(selectedTheme: selectedTheme))
                }

                if networkMonitor.showBanner {
                    VStack {
                        NetworkMonitorBannerView(bannerType: networkMonitor.bannerType)
                            .transition(.move(edge: .top).combined(with: .opacity))
                        Spacer()
                    }
                    .zIndex(3)
                }
            }
            .animation(.easeInOut(duration: 0.5), value: coordinator.showSplashScreen)
            .animation(.easeInOut, value: networkMonitor.showBanner)
        }
    }
}
