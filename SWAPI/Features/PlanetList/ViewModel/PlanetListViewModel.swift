//
//  PlanetListViewModel.swift
//  SWAPI
//
//  Created by Nilusha Niwanthaka Wimalasena on 8/9/25.
//

import Foundation

class PlanetListViewModel: ObservableObject {
    
    @Published private(set) var planets: [Planet] = []
    
    let service: Servicing
    
    init(service: Servicing) {
        self.service = service
    }
    
    @MainActor
    func fetchPlanetData() async {
        do {
            let planetData = try await service.fetchPlanetData()
            print(planetData)
            planets = planetData
        } catch {
            
        }
    }
}
