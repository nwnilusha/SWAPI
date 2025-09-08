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
    
    static let planetCacheData = NSCache<NSString, NSArray>()
    static let planetPageCache = NSCache<NSString, NSNumber>()
    
    private var cancellables = Set<AnyCancellable>()
    
    let service: Servicing
    
    init(service: Servicing) {
        self.service = service
        searchPlanet()
    }
    
    @MainActor
    func loadInitialData() async {
        if !self.planets.isEmpty {
            return
        } else if let cachePlanets = Self.planetCacheData.object(forKey: CacheKey.allPlanetsCacheKey as NSString) as? [Planet] {
            self.planets = cachePlanets
            self.filteredPlanets = cachePlanets
        } else {
            await fetchPlanetData()
        }
    }
    
    @MainActor
    func fetchPlanetData() async {
        guard !isLoading else { return }
        isLoading = true
        
        defer {
            isLoading = false
        }
        
        do {
            let planetData = try await service.fetchPlanetData()
            
            self.planets = planetData
            self.filteredPlanets = planets
            
            Self.planetCacheData.setObject(planets as NSArray, forKey: CacheKey.allPlanetsCacheKey as NSString)
            
        } catch {
            if let apiError = error as? RequestError {
                errorMessage = apiError.errorDiscription
                print("Fetch data failed: \(apiError.errorDiscription)")
            } else {
                errorMessage = "Unknown error occurred"
            }
        }
    }
    
    func searchPlanet() {
        $searchedText
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
        Self.planetCacheData.removeAllObjects()
        Self.planetPageCache.removeAllObjects()
    }
}
