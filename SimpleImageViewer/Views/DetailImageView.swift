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
                VStack {
                    GeometryReader { proxy in
                        ScrollView([.horizontal, .vertical]) {
                            SingleImageView(viewModel: imageViewModel,
                                            imageURL: url,
                                            containerSize: proxy.size)
                        }
                    }
                    Text(viewModel.imageURL?.absoluteString ?? "")
                }
            }
            else {
                Text("Select an image from the list")
            }
        }
    }
     
    private let imageViewModel = SingleImageViewModel()
    
}

struct DetailImageView_Previews: PreviewProvider {
    static var previews: some View {
        DetailImageView(viewModel: DetailImageViewModel())
    }
}
