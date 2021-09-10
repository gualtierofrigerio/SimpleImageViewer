//
//  ImageLoader.swift
//  SimpleImageViewer
//
//  Created by Gualtiero Frigerio on 03/02/2021.
//

import Combine
import Foundation

/// Observable object responsible to load an image to be used by SwiftUI views
class ImageLoader: ObservableObject {
    var didChange = PassthroughSubject<Data, Never>()
    var data = Data() {
        didSet {
            didChange.send(data)
        }
    }
    
    /// Load an image at the given URL
    /// - Parameter url: The image URL
    func load(url: URL) {
        loadImage(fromURL: url)
    }
    
    /// Load an image from a given string
    /// - Parameter urlString: The string representing the image URL
    func load(urlString:String) {
        guard let url = URL(string: urlString) else { return }
        loadImage(fromURL: url)
    }
    
    private func loadImage(fromURL url:URL) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.data = data
            }
        }
        task.resume()
    }
}
