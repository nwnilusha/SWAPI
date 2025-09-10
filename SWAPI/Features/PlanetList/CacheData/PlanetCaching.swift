//
//  PlanetCaching.swift
//  SWAPI
//
//  Created by Nilusha Niwanthaka Wimalasena on 10/9/25.
//

import Foundation

protocol PlanetCaching {
    func save(planets: [Planet])
    func load() -> [Planet]?
    func clear()
}
