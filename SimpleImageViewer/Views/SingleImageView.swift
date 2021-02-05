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
        Text(imageURL.lastPathComponent)
    }
}

struct SingleImageView_Previews: PreviewProvider {
    static var previews: some View {
        SingleImageView(imageURL: URL(string: "")!)
    }
}
