//
//  ImageLoader.swift
//  SimpleImageViewer
//
//  Created by Gualtiero Frigerio on 03/02/2021.
//

import Combine
import Foundation

class ImageLoader: ObservableObject {
    var didChange = PassthroughSubject<Data, Never>()
    var data = Data() {
        didSet {
            didChange.send(data)
        }
    }
    
    init(url:URL) {
        loadImage(fromURL: url)
    }
    
    init(urlString:String) {
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
