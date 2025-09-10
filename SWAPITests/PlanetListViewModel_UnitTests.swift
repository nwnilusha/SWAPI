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
    
    private var cache: MockCache!
    private var service: MockService!
    
    override func setUp() {
        super.setUp()
        cache = MockCache()
        service = MockService()
    }
    
    override func tearDown() {
        cache = nil
        service = nil
        super.tearDown()
    }

    func testInitialState() {
        let vm = PlanetListViewModel(service: service, cache: cache)
        XCTAssertTrue(vm.planets.isEmpty)
        XCTAssertTrue(vm.filteredPlanets.isEmpty)
        XCTAssertEqual(vm.searchedText, "")
        XCTAssertNil(vm.errorMessage)
        XCTAssertFalse(vm.isLoading)
        XCTAssertFalse(vm.isSearching)
    }

    func testLoadFromCache() async {
        cache.savedPlanets = Planet.mockPlanets
        
        let vm = PlanetListViewModel(service: service, cache: cache)
        await vm.fetchPlanetData()
        
        XCTAssertEqual(vm.planets.count, 10)
        XCTAssertEqual(vm.filteredPlanets.first?.name, "Mirial")
    }
    
    func testLoadFromServiceWhenCacheEmpty() async {
        let vm = PlanetListViewModel(service: service, cache: cache)
        await vm.fetchPlanetData()
        
        XCTAssertEqual(vm.planets.count, 10)
        XCTAssertEqual(cache.savedPlanets?.count, 10)
    }

    func testSuccessfulFetch() async {
        let vm = PlanetListViewModel(service: service, cache: cache)
        await vm.fetchPlanetData()
        
        XCTAssertFalse(vm.planets.isEmpty)
        XCTAssertEqual(vm.filteredPlanets.count, vm.planets.count)
        XCTAssertNil(vm.errorMessage)
    }
    
    func testFetchEmptyData() async {
        let vm = PlanetListViewModel(service: MockEmptyData(), cache: cache)
        await vm.fetchPlanetData()
        
        XCTAssertTrue(vm.planets.isEmpty)
        XCTAssertTrue(vm.filteredPlanets.isEmpty)
        XCTAssertNil(vm.errorMessage)
    }
    
    func testFetchFailureRequestError() async {
        let vm = PlanetListViewModel(service: MockServiceError(), cache: cache)
        await vm.fetchPlanetData()
        
        XCTAssertEqual(vm.errorMessage, RequestError.invalidURL.errorDiscription)
    }
    
    func testFetchFailureUnknownError() async {
        let vm = PlanetListViewModel(service: MockServiceThrowsUnknown(), cache: cache)
        await vm.fetchPlanetData()
        
        XCTAssertEqual(vm.errorMessage, "Unknown error occurred")
    }
    
    func testFetchSkipsIfAlreadyLoading() async {
        let vm = PlanetListViewModel(service: service, cache: cache)
        vm.isLoading = true
        await vm.fetchPlanetData()

        XCTAssertTrue(vm.planets.isEmpty)
    }

    func testSearchPlanetEmptyText() async {
        let vm = PlanetListViewModel(service: service, cache: cache)
        await vm.fetchPlanetData()
        
        vm.searchedText = ""
        XCTAssertEqual(vm.filteredPlanets.count, 10)
        XCTAssertFalse(vm.isSearching)
    }
    
    func testSearchPlanetWithMatch() async {
        let vm = PlanetListViewModel(service: service, cache: cache)
        await vm.fetchPlanetData()
        
        vm.searchedText = "Kalee"
        try? await Task.sleep(nanoseconds: 300_000_000)
        
        XCTAssertEqual(vm.filteredPlanets.first?.name, "Kalee")
        XCTAssertEqual(vm.filteredPlanets.count, 1)
        XCTAssertTrue(vm.isSearching)
    }
    
    func testSearchPlanetNoMatch() async {
        let vm = PlanetListViewModel(service: service, cache: cache)
        await vm.fetchPlanetData()
        
        vm.searchedText = "Earth"
        try? await Task.sleep(nanoseconds: 300_000_000)
        
        XCTAssertEqual(vm.filteredPlanets.count, 0)
        XCTAssertTrue(vm.isSearching)
    }

    func testClearCache() {
        cache.savedPlanets = Planet.mockPlanets
        XCTAssertNotNil(cache.savedPlanets)
        
        let vm = PlanetListViewModel(service: service, cache: cache)
        vm.clearCache()
        
        XCTAssertNil(cache.savedPlanets)
        XCTAssertTrue(cache.cleared)
    }
}

