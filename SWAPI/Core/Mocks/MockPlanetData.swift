//
//  MockPlanetData.swift
//  SWAPI
//
//  Created by Nilusha Niwanthaka Wimalasena on 8/9/25.
//

import Foundation

extension Planet {
    static var mockPlanets: [Planet] {
        Bundle.main.decode([Planet].self, from: "mock_planets.json")
    }
}
