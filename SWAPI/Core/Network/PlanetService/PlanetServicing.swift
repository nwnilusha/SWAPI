//
//  PlanetServicing.swift
//  SWAPI
//
//  Created by Nilusha Niwanthaka Wimalasena on 8/9/25.
//

import Foundation

protocol PlanetServicing {
    func fetchPlanetData() async throws -> [Planet]
}
