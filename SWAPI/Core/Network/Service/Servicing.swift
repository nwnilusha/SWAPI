//
//  Servicing.swift
//  SWAPI
//
//  Created by Nilusha Niwanthaka Wimalasena on 8/9/25.
//

import Foundation

protocol Servicing {
    func fetchPlanetData() async throws -> [Planet]
}
