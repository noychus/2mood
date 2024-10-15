//
//  ProductDataState.swift
//  MOOD2
//
//  Created by NOY on 15.10.2024.
//

import Foundation

struct ProductDataState {
    var products: [Product] = []
    var isLoading: Bool = false
    var error: Error? = nil
}
