//
//  Planet.swift
//  SWAPI
//
//  Created by Nilusha Niwanthaka Wimalasena on 8/9/25.
//

import Foundation

struct Planet: Codable, Hashable {
    let name: String
    let rotationPeriod: String
    let orbitalPeriod: String
    let diameter: String
    let climate: String
    let gravity: String
    let terrain: String
    let surfaceWater: String
    let population: String
    let residents: [String]
    let films: [String]
    let created: String
    let edited: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case name
        case rotationPeriod = "rotation_period"
        case orbitalPeriod = "orbital_period"
        case diameter
        case climate
        case gravity
        case terrain
        case surfaceWater = "surface_water"
        case population
        case residents
        case films
        case created
        case edited
        case url
    }
}

extension Planet {
    static let mockPlanet = Planet(
        name: "Tatooine",
        rotationPeriod: "23",
        orbitalPeriod: "304",
        diameter: "10465",
        climate: "Arid",
        gravity: "1 standard",
        terrain: "Desert",
        surfaceWater: "1",
        population: "200000",
        residents: [
            "https://swapi.dev/api/people/1/",
            "https://swapi.dev/api/people/2/",
            "https://swapi.dev/api/people/4/" 
        ],
        films: [
            "https://swapi.dev/api/films/1/",
            "https://swapi.dev/api/films/3/"
        ],
        created: "2014-12-09T13:50:49.641000Z",
        edited: "2014-12-20T20:58:18.411000Z",
        url: "https://swapi.dev/api/planets/1/"
    )
}

