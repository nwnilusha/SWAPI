//
//  AppCoordinator.swift
//  SWAPI
//
//  Created by Nilusha Niwanthaka Wimalasena on 8/9/25.
//

import Foundation
import SwiftUI

class AppCoordinator: ObservableObject {
    
    @Published var path = NavigationPath()
    @Published var showSplashScreen = true
    
    private let httpService: APIClientProtocol
    private let service: PlanetServicing
    private let cache: PlanetCaching
    
    init() {
        self.httpService = APIClient()
        self.cache = PlanetMemoryCache()
        if CommandLine.arguments.contains("--uitesting") {
            self.service = MockService()
        } else {
            self.service = PlanetService(httpService: httpService)
        }
    }
    
    func buildSplashScreen() -> some View {
        return SplashScreenView()
    }
    
    func buildInitialView() -> some View {
        let vm = PlanetListViewModel(service: self.service, cache: cache)
        return PlanetListView(viewModel: vm)
    }
    
    func buildDestination(for route: Routes) -> some View {
        switch route {
        case .PlanetDetails(let planet):
            return AnyView(PlanetDetailView(planet: planet))
        case .Settings:
            return AnyView(SettingsView())
        }
    }
    
    func push(_ route: Routes) {
        path.append(route)
    }
    
    func reset() {
        path = NavigationPath()
    }
    
    func hideSplashScreen() {
        withAnimation(.easeOut(duration: 0.5)) {
            showSplashScreen = false
        }
    }
}
