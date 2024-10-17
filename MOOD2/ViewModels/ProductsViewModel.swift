//
//  ProductViewModel.swift
//  MOOD2
//
//  Created by NOY on 15.10.2024.
//

import Foundation
import SwiftUI
import Combine

class ProductsViewModel: ObservableObject {
    @Published private(set) var state = ProductDataState()
    private let networkingService = NetworkingService()
    private var cancellables = Set<AnyCancellable>()
    
    func loadProducts(page: Int = 1, limit: Int = 720) async {
        
        state.isLoading = true
        state.error = nil
        
        do {
            let welcome: Welcome = try await networkingService.performRequest(for: .getProducts(page: page, limit: limit))
            
            DispatchQueue.main.async {
                self.state.products = welcome.data.products
                self.state.isLoading = false
            }
        } catch {
            DispatchQueue.main.async {
                self.state.isLoading = false
                self.state.error = error
            }
            print("Error loading products: \(error)")
        }
    }
    func loadMoreIfNeeded(currentItem product: Product, page: Int = 1, limit: Int = 10) async {
        guard let lastProduct = state.products.last, lastProduct.id == product.id, !state.isLoading else {
            return
        }
        
        await loadProducts(page: page + 1, limit: limit)
    }
}
