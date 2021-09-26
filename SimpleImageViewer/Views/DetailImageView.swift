//
//  DetailImageView.swift
//  DetailImageView
//
//  Created by Gualtiero Frigerio on 27/08/21.
//

import SwiftUI

struct DetailImageView: View {
    @ObservedObject var viewModel: DetailImageViewModel
    
    var body: some View {
        VStack {
            if let url = viewModel.imageURL {
                GeometryReader { proxy in
                    ScrollView([.horizontal, .vertical]) {
                        SingleImageView(imageURL: url, containerSize: proxy.size)
                    }
                }
            }
            else {
                Text("Select an image from the list")
            }
        }
    }
}

struct DetailImageView_Previews: PreviewProvider {
    static var previews: some View {
        DetailImageView(viewModel: DetailImageViewModel())
    }
}
