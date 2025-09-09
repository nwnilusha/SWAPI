//
//  ApiEndpoint.swift
//  SWAPI
//
//  Created by Nilusha Niwanthaka Wimalasena on 8/9/25.
//

import Foundation

enum ApiEndpoint: Endpoint {
    case planets
    
    var scheme: String {
        switch self {
        case .planets:
            return "https"
        }
    }
    
    var host: String {
        switch self {
        case .planets:
            return "swapi.info"
        }
    }
    
    var path: String {
        switch self {
        case .planets:
            return "/api/planets"
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .planets:
            return .get
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .planets:
            return nil
        }
    }
    
    var body: [String : Any]? {
        switch self {
        case .planets:
            return nil
        }
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .planets:
            return nil
        }
    }
}
