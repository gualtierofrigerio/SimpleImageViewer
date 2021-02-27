//
//  ImageViewLazy.swift
//  SimpleImageViewer
//
//  Created by Gualtiero Frigerio on 25/02/21.
//

import SwiftUI

struct ImageViewLazy: View {
    @ObservedObject var imageLoader = ImageLoader()
    @State var image:NSImage?
    
    init(withURL url:URL) {
        imageURL = url
    }
    
    init(withURL url:URL, maxSize:Int) {
        imageURL = url
    }
    
    var body: some View {
        VStack {
            if image != nil {
                Image(nsImage: image!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            else {
                Image(nsImage: NSImage())
                    .resizable()
            }
        }.onAppear {
            if image == nil {
                imageLoader.load(url: imageURL)
            }
        }.onReceive(imageLoader.didChange) { data in
            self.image = NSImage(data: data)
        }
    }
    
    private var imageURL:URL
}

struct ImageViewLazy_Previews: PreviewProvider {
    static var previews: some View {
        ImageViewLazy(withURL: URL(string:"")!)
    }
}
