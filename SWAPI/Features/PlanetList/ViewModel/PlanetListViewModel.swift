//
//  PlanetListViewModel.swift
//  SWAPI
//
//  Created by Nilusha Niwanthaka Wimalasena on 8/9/25.
//

import Foundation
import Combine

class PlanetListViewModel: ObservableObject {
    
    @Published private(set) var planets: [Planet] = []
    @Published private(set) var filteredPlanets: [Planet] = []
    @Published var searchedText: String = ""
    @Published var errorMessage: String?
    @Published var isLoading: Bool = false
    @Published var isSearching: Bool = false

    private var cancellables = Set<AnyCancellable>()
    
    let service: PlanetServicing
    let cache: PlanetCaching
    
    init(service: PlanetServicing, cache: PlanetCaching) {
        self.service = service
        self.cache = cache
        searchPlanet()
    }
    
    @MainActor
    func fetchPlanetData(forceRefresh: Bool = false) async {
        guard !isLoading else { return }
        isLoading = true
        
        defer {
            isLoading = false
        }
        
        if !forceRefresh,let cached = cache.load() {
            self.planets = cached
            self.filteredPlanets = cached
        } else {
            do {
                let planetData = try await service.fetchPlanetData()
                
                self.planets = planetData
                self.filteredPlanets = planetData
                
                cache.save(planets: planets)
            } catch {
                if let apiError = error as? RequestError {
                    errorMessage = apiError.errorDiscription
                    print("Fetch data failed: \(apiError.errorDiscription)")
                } else {
                    errorMessage = "Unknown error occurred"
                }
            }
        }
    }
    
    func searchPlanet() {
        $searchedText
            .debounce(for: .milliseconds(250), scheduler: RunLoop.main)
            .sink { [weak self] text in
                guard let self = self else { return }
                if text.isEmpty {
                    self.isSearching = false
                    self.filteredPlanets = self.planets
                } else {
                    self.isSearching = true
                    self.filteredPlanets = self.planets.filter{$0.name.lowercased().hasPrefix(text.lowercased())}
                }
            }
            .store(in: &cancellables)
    }
    
    func clearCache() {
        cache.clear()
    }
}
