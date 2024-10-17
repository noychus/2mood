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
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack {
                            Spacer().frame(width: 8)
                            
                            ForEach(vm.state.products, id: \.title) { product in
                                ProductsSmallCell(product: product)
                            }
                            
                            Spacer().frame(width: 8)
                        }
                    }
                    .frame(height: 300)
                    
                    if let product = vm.state.products.last {
                        ProductBigCell(product: product)
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
