//
//  BundleExtention.swift
//  SWAPI
//
//  Created by Nilusha Niwanthaka Wimalasena on 8/9/25.
//

import Foundation

extension Bundle {
    
    enum DecodeError: Error {
        case fileNotFound(String)
        case dataLoadingFailed(String)
        case decodingFailed(String, Error)
    }
    
    public func decode<T: Decodable>(_ type: T.Type, from file: String,
                                     decoder: JSONDecoder = JSONDecoder()) throws -> T {
        guard let url = url(forResource: file, withExtension: nil) else {
            throw DecodeError.fileNotFound("Failed to locate \(file) in bundle.")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            throw DecodeError.dataLoadingFailed("Failed to load \(file) as Data.")
        }
        
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            throw DecodeError.decodingFailed("Failed to decode \(file)", error)
        }
    }
    
    var appVersion: String {
        infoDictionary?["CFBundleShortVersionString"] as? String ?? "N/A"
    }
    
    var buildNumber: String {
        infoDictionary?["CFBundleVersion"] as? String ?? "N/A"
    }
}
