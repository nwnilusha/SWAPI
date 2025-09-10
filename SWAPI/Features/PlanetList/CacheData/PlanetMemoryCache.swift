//
//  PlanetMemoryCache.swift
//  SWAPI
//
//  Created by Nilusha Niwanthaka Wimalasena on 10/9/25.
//

import Foundation

final class PlanetMemoryCache: PlanetCaching {
    private let cache = NSCache<NSString, NSArray>()

    func save(planets: [Planet]) {
        cache.setObject(planets as NSArray, forKey: CacheKey.allPlanetsCacheKey as NSString)
    }

    func load() -> [Planet]? {
        return cache.object(forKey: CacheKey.allPlanetsCacheKey as NSString) as? [Planet]
    }

    func clear() {
        cache.removeAllObjects()
    }
}
