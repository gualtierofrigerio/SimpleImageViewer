//
//  SingleImageView.swift
//  SimpleImageViewer
//
//  Created by Gualtiero Frigerio on 05/02/21.
//

import SwiftUI

struct SingleImageView: View {
    var imageURL:URL
    
    var body: some View {
        ImageView(withURL: imageURL)
            .frame(width: 1024 * self.scale, height: 1024 * self.scale)
            .gesture(MagnificationGesture()
                        .onChanged { value in
                            if checkScale(value.magnitude) {
                                self.scale = value.magnitude
                            }
                        }
                    )
        Text(imageURL.lastPathComponent)
    }
    
    @State private var scale: CGFloat = 1.0
    
    private func checkScale(_ scale: CGFloat) -> Bool {
        scale > 0.5 && scale < 3
    }
}

struct SingleImageView_Previews: PreviewProvider {
    static var previews: some View {
        SingleImageView(imageURL: URL(string: "")!)
    }
}
