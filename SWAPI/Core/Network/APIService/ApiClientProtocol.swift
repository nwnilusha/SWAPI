//
//  ApiClientProtocol.swift
//  SWAPI
//
//  Created by Nilusha Niwanthaka Wimalasena on 10/9/25.
//

import Foundation

protocol APIClientProtocol {
    func sendRequest <T: Decodable>(session: URLSession, endpoint: Endpoint, responseModel: T.Type) async throws -> T
}
