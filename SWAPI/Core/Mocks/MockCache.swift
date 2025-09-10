//
//  MockCache.swift
//  SWAPI
//
//  Created by Nilusha Niwanthaka Wimalasena on 10/9/25.
//

import Foundation

class MockCache: PlanetCaching {
    var savedPlanets: [Planet]?
    var cleared = false
    
    func load() -> [Planet]? {
        return savedPlanets
    }
    
    func save(planets: [Planet]) {
        savedPlanets = planets
    }
    
    func clear() {
        savedPlanets = nil
        cleared = true
    }
}
