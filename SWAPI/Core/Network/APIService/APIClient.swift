//
//  APIClient.swift
//  SWAPI
//
//  Created by Nilusha Niwanthaka Wimalasena on 8/9/25.
//

import Foundation

class APIClient: APIClientProtocol {
    
    func sendRequest<T: Decodable>(session: URLSession, endpoint: any Endpoint, responseModel: T.Type) async throws -> T {
        var urlComponent = URLComponents()
        urlComponent.scheme = endpoint.scheme
        urlComponent.host = endpoint.host
        urlComponent.path = endpoint.path
        urlComponent.queryItems = endpoint.queryItems
        
        guard let url = urlComponent.url else {
            throw RequestError.invalidURL
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = endpoint.method.rawValue
        if let requestHeaders = endpoint.headers {
            urlRequest.allHTTPHeaderFields = requestHeaders
        }
        
        if let requestBody = endpoint.body {
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: requestBody, options: [])
        }
        
        do {
            let (data, response) = try await session.data(for: urlRequest)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw RequestError.noResponse
            }
            
            switch httpResponse.statusCode {
            case 200..<300:
                break
            case 401:
                throw RequestError.unauthorized
            case 425:
                throw RequestError.workInProgress
            default:
                throw RequestError.unexpectedStatusCode
            }
            
            guard !data.isEmpty else {
                throw RequestError.emptyResponse
            }
            
            do {
                let decodeData = try JSONDecoder().decode(T.self , from: data)
                return decodeData
            } catch {
                throw RequestError.decodingError(error.localizedDescription)
            }
        } catch let error as RequestError {
            throw error
        }
        catch {
            throw RequestError.dataTaskError(error.localizedDescription)
        }
    }
}

enum RequestError: Error {
    case invalidURL
    case noResponse
    case emptyResponse
    case unauthorized
    case unexpectedStatusCode
    case workInProgress
    case dataTaskError(String)
    case curruptData
    case decodingError(String)
    
    var errorDiscription: String {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .noResponse:
            return "No Response"
        case .emptyResponse:
            return "Empty Response"
        case .dataTaskError(let message):
            return message
        case .curruptData:
            return "Currupt Data"
        case .decodingError(let message):
            return message
        case .unauthorized:
            return "Unauthorized"
        case .unexpectedStatusCode:
            return "Unexpected Status Code"
        case .workInProgress:
            return "Work In Progress"
        }
    }
}

