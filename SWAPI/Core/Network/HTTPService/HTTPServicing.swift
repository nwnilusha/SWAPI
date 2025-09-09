//
//  HTTPServicing.swift
//  SWAPI
//
//  Created by Nilusha Niwanthaka Wimalasena on 8/9/25.
//

import Foundation

protocol HTTPServicing {
    func sendRequest <T: Decodable>(session: URLSession, endpoint: Endpoint, responseModel: T.Type) async throws -> T
}
