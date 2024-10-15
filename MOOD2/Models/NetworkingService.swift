//
//  NetworkingService.swift
//  MOOD2
//
//  Created by NOY on 15.10.2024.
//

import Foundation

class NetworkingService {
    func performRequest<T: Decodable>(for endpoint: API) async throws -> T {
        let url = try endpoint.url()
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method
        request.allHTTPHeaderFields = endpoint.headers
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, (200...2999).contains(httpResponse.statusCode) else {
            print("\(response)")
            throw APIError.invalidResponse(response: response)
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(T.self, from: data)
        } catch {
            print("Decoding error: \(error)")
            throw APIError.decodingError(error: error)
        }
    }
}
