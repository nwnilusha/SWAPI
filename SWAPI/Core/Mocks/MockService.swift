//
//  MockService.swift
//  SWAPI
//
//  Created by Nilusha Niwanthaka Wimalasena on 8/9/25.
//

import Foundation

struct MockService: PlanetServicing {
    func fetchPlanetData() async throws -> [Planet] {
        return Planet.mockPlanets
    }
}

class MockServiceError: PlanetServicing {
    func fetchPlanetData() async throws -> [Planet] {
        throw RequestError.invalidURL
    }
}

class MockEmptyData: PlanetServicing {
    func fetchPlanetData() async throws -> [Planet] {
        return []
    }
}

class MockServiceThrowsUnknown: PlanetServicing {
    struct DummyError: Error {}
    
    func fetchPlanetData() async throws -> [Planet] {
        throw DummyError()
    }
}
