//
//  PlanetListViewModel_UnitTests.swift
//  SWAPITests
//
//  Created by Nilusha Niwanthaka Wimalasena on 8/9/25.
//

import XCTest
import Combine
@testable import SWAPI

final class PlanetListViewModelTests: XCTestCase {
    
    override func tearDown() {
        PlanetListViewModel.planetCacheData.removeAllObjects()
        super.tearDown()
    }

    func testInitialState() {
        let vm = PlanetListViewModel(service: MockService())
        XCTAssertTrue(vm.planets.isEmpty)
        XCTAssertTrue(vm.filteredPlanets.isEmpty)
        XCTAssertEqual(vm.searchedText, "")
        XCTAssertNil(vm.errorMessage)
        XCTAssertFalse(vm.isLoading)
        XCTAssertFalse(vm.isSearching)
    }

    func testLoadInitialDataFromCache() async {
        let cached = Planet.mockPlanets
        PlanetListViewModel.planetCacheData.setObject(cached as NSArray,
                                                      forKey: CacheKey.allPlanetsCacheKey as NSString)
        
        let vm = PlanetListViewModel(service: MockEmptyData())
        await vm.loadInitialData()
        
        XCTAssertEqual(vm.planets.count, 10)
        XCTAssertEqual(vm.filteredPlanets.first?.name, "Mirial")
    }
    
    func testLoadInitialDataLoaded() async {
        let vm = PlanetListViewModel(service: MockService())
        XCTAssertNotEqual(vm.planets.count, 10)
        await vm.loadInitialData()
        XCTAssertEqual(vm.planets.count, 10)
    }

    func testSuccessfulFetch() async {
        let vm = PlanetListViewModel(service: MockService())
        await vm.fetchPlanetData()
        
        XCTAssertFalse(vm.planets.isEmpty)
        XCTAssertEqual(vm.filteredPlanets.count, vm.planets.count)
        XCTAssertNil(vm.errorMessage)
    }
    
    func testFetchEmptyData() async {
        let vm = PlanetListViewModel(service: MockEmptyData())
        await vm.fetchPlanetData()
        
        XCTAssertTrue(vm.planets.isEmpty)
        XCTAssertTrue(vm.filteredPlanets.isEmpty)
        XCTAssertNil(vm.errorMessage)
    }
    
    func testFetchFailureRequestError() async {
        let vm = PlanetListViewModel(service: MockServiceError())
        await vm.fetchPlanetData()
        
        XCTAssertEqual(vm.errorMessage, RequestError.invalidURL.errorDiscription)
    }
    
    func testFetchFailureUnknownError() async {
        let vm = PlanetListViewModel(service: MockServiceThrowsUnknown())
        await vm.fetchPlanetData()
        
        XCTAssertEqual(vm.errorMessage, "Unknown error occurred")
    }
    
    func testFetchSkipsIfAlreadyLoading() async {
        let vm = PlanetListViewModel(service: MockService())
        vm.isLoading = true
        await vm.fetchPlanetData()

        XCTAssertTrue(vm.planets.isEmpty)
    }

    func testSearchPlanetEmptyText() async {
        let vm = PlanetListViewModel(service: MockService())
        await vm.fetchPlanetData()
        
        vm.searchedText = ""
        XCTAssertEqual(vm.filteredPlanets.count, 10)
        XCTAssertFalse(vm.isSearching)
    }
    
    func testSearchPlanetWithMatch() async {
        let vm = PlanetListViewModel(service: MockService())
        await vm.fetchPlanetData()
        
        vm.searchedText = "Kalee"
        try? await Task.sleep(nanoseconds: 300_000_000)
        XCTAssertEqual(vm.filteredPlanets.first?.name, "Kalee")
        XCTAssertEqual(vm.filteredPlanets.count, 1)
        XCTAssertTrue(vm.isSearching)
    }
    
    func testSearchPlanetNoMatch() async {
        let vm = PlanetListViewModel(service: MockService())
        await vm.fetchPlanetData()
        
        vm.searchedText = "Earth"
        try? await Task.sleep(nanoseconds: 300_000_000)
        XCTAssertEqual(vm.filteredPlanets.count, 0)
        XCTAssertTrue(vm.isSearching)
    }

    func testClearCache() {
        PlanetListViewModel.planetCacheData.setObject(Planet.mockPlanets as NSArray,
                                                      forKey: CacheKey.allPlanetsCacheKey as NSString)
        
        XCTAssertNotNil(PlanetListViewModel.planetCacheData.object(forKey: CacheKey.allPlanetsCacheKey as NSString))
        
        let vm = PlanetListViewModel(service: MockService())
        vm.clearCache()
        
        XCTAssertNil(PlanetListViewModel.planetCacheData.object(forKey: CacheKey.allPlanetsCacheKey as NSString))
    }
}

