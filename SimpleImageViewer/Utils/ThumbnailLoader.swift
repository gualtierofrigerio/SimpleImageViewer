//
//  ThumbnailLoader.swift
//  ThumbnailLoader
//
//  Created by Gualtiero Frigerio on 23/08/21.
//

import AppKit
import QuickLookThumbnailing

/// Wrapper for QLThumbnailGenerator
/// the class is ObservableObject and has a @Published var so
/// a view can observe it and load a thumbnail as soon as it is ready
class ThumbnailLoader: ObservableObject {
    @Published var image = NSImage()
    
    /// Tries to load a thumbnail for a given URL
    /// - Parameters:
    ///   - url: URL of the image
    ///   - maxSize: maximum size (width/height) aspect ratio preserved
    func loadThumbnail(url: URL, maxSize: Int) {
        let size = CGSize(width: maxSize, height: maxSize)
        let scale = 1.0
        let request = QLThumbnailGenerator.Request(fileAt: url,
                                                       size: size,
                                                       scale: scale,
                                                       representationTypes: .all)
            
        let generator = QLThumbnailGenerator.shared
        generator.generateRepresentations(for: request) { (thumbnail, type, error) in
            guard let nsImage = thumbnail?.nsImage else {
                if let error = error {
                    print("error while generating thumbnail \(error.localizedDescription)")
                }
                return
            }
            DispatchQueue.main.async {
                self.image = nsImage
            }
        }
    }
}
