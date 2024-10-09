//
//  APIService.swift
//  MOOD2
//
//  Created by NOY on 09.10.2024.
//

import Foundation
import Combine

class APIService {
    private var token: String = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJmdXNlcklkIjoiMTA1NzUxMjQiLCJsbmciOiJydSIsImxvYyI6Ijg0IiwiaWF0IjoxNzI4MzMyNjc3LCJleHAiOjE3Mjg5Mzc0NzcsImp0aSI6Im5hYTI2NnJzcW5tNzNwNXRsYXRzbjdocmY4IiwibmV4dFNlbmQiOjAsInRyeUNvdW50IjowfQ.TeyhRx9UEhf9SO-Pf-oDPJ-6aXA3oDGvIZkxo9k8CRY"
    
    func fetchProducts(page: Int, limit: Int, count: Int, completion: @escaping (Result<[Product], Error>) -> Void) {
        let baseURL = "https://www.2moodstore.com/api/v1/products"
        guard let url = URL(string: "\(baseURL)?page=\(page)&limit=\(limit)") else { return }
        
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("same-origin", forHTTPHeaderField: "Sec-Fetch-Site")
        request.addValue("Accept-Encoding", forHTTPHeaderField: "Accept-Encoding")
        request.addValue("ru", forHTTPHeaderField: "Accept-Language")
        request.addValue("cors", forHTTPHeaderField: "Accept-Language")
        request.addValue("www.2moodstore.com", forHTTPHeaderField: "Host")
        request.addValue("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.4.1 Safari/605.1.15", forHTTPHeaderField: "User-Agent")
        request.addValue("keep-alive", forHTTPHeaderField: "Connection")
        request.addValue("https://www.2moodstore.com/", forHTTPHeaderField: "Referer")
        request.addValue(token, forHTTPHeaderField: "x-auth-token")
        
        URLSession.shared.dataTask(with: request) { data, responce, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else { return }
            
            do {
                let decoder = try JSONDecoder().decode(Welcome.self, from: data)
                completion(.success(decoder.data.products))
            } catch {
                completion(.failure(error))
            }
        }
        .resume()
    }
}
