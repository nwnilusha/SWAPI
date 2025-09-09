//
//  PlanetService.swift
//  SWAPI
//
//  Created by Nilusha Niwanthaka Wimalasena on 8/9/25.
//

import Foundation

struct PlanetService: PlanetServicing {
    
    let httpService: HTTPServicing
    
    func fetchPlanetData() async throws -> [Planet] {
        do {
            let response = try await httpService.sendRequest(
                session: URLSession.shared,
                endpoint: ApiEndpoint.planets,
                responseModel: [Planet].self
            )
            return response
        } catch {
            throw error
        }
    }
}
