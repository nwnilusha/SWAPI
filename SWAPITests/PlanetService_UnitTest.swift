//
//  PlanetService_UnitTest.swift
//  SWAPITests
//
//  Created by Nilusha Niwanthaka Wimalasena on 8/9/25.
//

import XCTest
@testable import SWAPI

final class PlanetService_UnitTest: XCTestCase {
    
    func testFetchPlanetsSuccess() async throws {
        let mockHTTPService = MockHTTPService()
        let planetService = PlanetService(httpService: mockHTTPService)
        let expectedPlanets = Planet.mockPlanets
        mockHTTPService.result = .success(expectedPlanets)
        
        let planets = try await planetService.fetchPlanetData()
        
        XCTAssertEqual(planets.count, 10)
        XCTAssertEqual(planets.first?.name, "Mirial")
    }

    func testFetchPlanetsFailure() async {
        let mockHTTPService = MockHTTPService()
        let planetService = PlanetService(httpService: mockHTTPService)
        mockHTTPService.result = .failure(RequestError.noResponse)
        
        do {
            _ = try await planetService.fetchPlanetData()
            XCTFail("Expected error, but got success")
        } catch {
            XCTAssertTrue(error is RequestError)
        }
    }
    
}
