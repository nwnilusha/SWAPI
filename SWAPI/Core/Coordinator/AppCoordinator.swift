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
    
    let httpService: HTTPServicing
    let service: Servicing
    
    init() {
        self.httpService = HTTPService()
        self.service = Service(httpService: httpService)
    }
    
    func buildInitialView() -> some View {
        let vm = PlanetListViewModel(service: self.service)
        return AnyView(PlanetListView(viewModel: vm))
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
}
