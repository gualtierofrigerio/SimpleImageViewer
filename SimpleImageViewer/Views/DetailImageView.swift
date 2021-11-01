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
            if let _ = viewModel.imageURL {
                VStack {
                    GeometryReader { proxy in
                        ScrollView([.horizontal, .vertical]) {
                            SingleImageView(viewModel: viewModel.singleImageViewModel,
                                            containerSize: proxy.size)
                        }
                    }
                    HStack {
                        Text(viewModel.imageURL?.absoluteString ?? "")
                        Stepper("Zoom level \(viewModel.currentZoomDisplay)",
                                value: $viewModel.stepperValue,
                                in: 0...9)
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
