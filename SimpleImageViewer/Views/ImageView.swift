//
//  ImageView.swift
//  SimpleImageViewer
//
//  Created by Gualtiero Frigerio on 03/02/2021.
//

import Combine
import SwiftUI

struct ImageView: View {
    @ObservedObject var imageLoader = ImageLoader()
    @State var image:NSImage = NSImage()
    
    init(withURL url:URL) {
        imageLoader.load(url:url)
    }
    
    init(withURL url:URL, maxSize:Int) {
        imageLoader.load(url:url)
        self.maxSize = maxSize
    }
    
    var body: some View {
        VStack {
            Image(nsImage: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
        .onReceive(imageLoader.didChange) { data in
            if maxSize > 0 {
                if let smallImage = getSmallImage(fromData:data) {
                    self.image = smallImage
                }
            }
            else {
                self.image = NSImage(data: data) ?? NSImage()
            }
        }
    }
    
    /// maximum size of the image
    /// If it is > 0 getSmallImage is called 
    private var maxSize:Int = 0
    
    /// Return a smaller image from a Data object containing an image
    /// The size of the image is determined by the maxSize variable
    /// - Parameter data: The image Data
    /// - Returns: The optional resized image is it was possible to convert Data to an NSImage
    private func getSmallImage(fromData data:Data) -> NSImage? {
        guard let ciImage = CIImage(data: data),
              let cgImage = CGImage.createFrom(ciImage: ciImage) else { return nil }
        let resizedImage = cgImage.resize(maxSize: maxSize)
        let nsImage = NSImage(cgImage: resizedImage,
                              size: CGSize(width: resizedImage.width, height: resizedImage.height))
        return nsImage
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView(withURL: URL(string:"")!)
    }
}
