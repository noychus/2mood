//
//  ImageLoadStatePublisher.swift
//  BigGeekStore
//
//  Created by NOY on 24.09.2024.
//

import Foundation
import SwiftUI
import Combine

class ImageLoadStatePublisher: ObservableObject {
    @Published var loadState: ImageLoadState = .idle
    
    enum ImageLoadState {
        case idle
        case loading
        case loaded(UIImage)
        case failed(ImageLoadError)
    }
    
    enum ImageLoadError: Error {
        case invalidData
        case networkError(Error)
        case unknownError
    }
}
