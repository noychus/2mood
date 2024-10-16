//
//  AsyncImage.swift
//  BigGeekStore
//
//  Created by NOY on 24.09.2024.
//

import Foundation
import SwiftUI

struct AsyncImage: View {
    let base = URL(string: "https://www.2moodstore.com/")
    let url: URL
    var fullURL: URL? {
        base?.appendingPathComponent(url.absoluteString)
    }
    
    @StateObject private var imageLoadStatePublisher = ImageLoadStatePublisher()
    @State private var task: Task<Void, Never>? = nil
    
    var body: some View {
        Group {
            switch imageLoadStatePublisher.loadState {
            case .loading:
                VStack {
                    
                }
            case .loaded(let image):
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
            default:
                HStack {
                    Image(systemName: "photo")
                }
            }
        }
        .onAppear {
            loadImage()
        }
        .onDisappear {
            task?.cancel()
        }
    }
    
    func loadImage() {
        guard let fullURL = fullURL else {
            imageLoadStatePublisher.loadState = .failed(.invalidData)
            return
        }
        
        imageLoadStatePublisher.loadState = .loading
        
        if let cachedImage = ImageCache.shared.image(for: fullURL) {
            imageLoadStatePublisher.loadState = .loaded(cachedImage)
            return
        }
        
        task?.cancel()
        
        task = Task {
            do {
                let (data, _) = try await URLSession.shared.data(from: fullURL)
                guard let image = UIImage(data: data) else {
                    DispatchQueue.main.async {
                        imageLoadStatePublisher.loadState = .failed(.invalidData)
                    }
                    return
                }
                
                ImageCache.shared.setImage(image, for: fullURL)
                DispatchQueue.main.async {
                    imageLoadStatePublisher.loadState = .loaded(image)
                }
            } catch {
                DispatchQueue.main.async {
                    if let urlError = error as? URLError {
                        imageLoadStatePublisher.loadState = .failed(.networkError(urlError))
                    } else {
                        imageLoadStatePublisher.loadState = .failed(.unknownError)
                    }
                }
            }
        }
    }
}
