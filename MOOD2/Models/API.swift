//
//  APIService.swift
//  MOOD2
//
//  Created by NOY on 09.10.2024.
//

import Foundation

enum API {
    case getProducts(page: Int, limit: Int)
    
    var baseURL: String { "https://www.2moodstore.com/api/v1" }
    
    var path: String {
        switch self {
        case .getProducts(let page, let limit):
            return "/products?page=\(page)&limit=\(limit)"
        }
    }
    
    var method: String { "GET" }
    
    var headers: [String: String]? {
        let token: String = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJmdXNlcklkIjoiMTA1NzUxMjQiLCJsbmciOiJydSIsImxvYyI6IjExMSIsImlhdCI6MTcyOTAwMjE0MSwiZXhwIjoxNzI5NjA2OTQxLCJqdGkiOiJuYWEyNjZyc3FubTczcDV0bGF0c243aHJmOCIsIm5leHRTZW5kIjowLCJ0cnlDb3VudCI6MH0.LcpBz_v53Z8lhZg9eJ9XCU-3aB-nmbvYrCTngX9hEac"
        
        return [
            "Accept": "application/json",
            "Sec-Fetch-Site": "same-origin",
            "Accept-Encoding": "gzip, deflate, br",
            "Accept-Language": "ru",
            "Host": "www.2moodstore.com",
            "User-Agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.4.1 Safari/605.1.15",
            "Connection": "keep-alive",
            "Referer": "https://www.2moodstore.com/",
            "x-auth-token": token
        ]
    }
    
    func url() throws -> URL {
        guard let url = URL(string: baseURL + path) else {
            throw APIError.invalidURL
        }
        return url
    }
}

enum APIError: Error, LocalizedError {
    case invalidURL
    case invalidResponse(response: URLResponse)
    case decodingError(error: Error)

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Неверный URL"
        case .invalidResponse:
            return "Неверный ответ от сервера"
        case .decodingError(let error):
            return "Ошибка декодирования: \(error.localizedDescription)"
        }
    }
}
