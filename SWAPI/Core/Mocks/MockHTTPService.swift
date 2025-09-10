//
//  MockHTTPService.swift
//  SWAPI
//
//  Created by Nilusha Niwanthaka Wimalasena on 8/9/25.
//

import Foundation

final class MockHTTPService: APIClientProtocol {
    var result: Result<[Planet], Error>?
    
    func sendRequest<T>(
        session: URLSession,
        endpoint: Endpoint,
        responseModel: T.Type
    ) async throws -> T where T : Decodable {
        switch result {
        case .success(let planets as T):
            return planets
        case .failure(let error):
            throw error
        default:
            fatalError("Unexpected type")
        }
    }
}
