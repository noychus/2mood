//
//  ProductsView.swift
//  MOOD2
//
//  Created by NOY on 15.10.2024.
//

import SwiftUI

struct ProductsView: View {
    
    @StateObject var vm = ProductsViewModel()
    
    var body: some View {
        NavigationStack {
            if vm.state.isLoading {
                ProgressView()
            } else if let error = vm.state.error {
                Text("Error: \(error.localizedDescription)")
            } else {
                List(vm.state.products, id: \.title) { product in
                    NavigationLink(destination: {}) {
                        ProductsCellView(product: product)
                    }
                }
            }
        }
        .onAppear {
            Task {
                await vm.loadProducts()
            }
        }
    }
}

#Preview {
    ProductsView()
}
