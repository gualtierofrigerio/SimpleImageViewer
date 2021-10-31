//
//  SingleImageView.swift
//  SimpleImageViewer
//
//  Created by Gualtiero Frigerio on 05/02/21.
//

import SwiftUI

struct SingleImageView: View {
    var imageURL: URL
    var containerSize: CGSize
    
    @ObservedObject var viewModel = SingleImageViewModel()
    
    var body: some View {
        Slider(value: $viewModel.sliderValue, in: 0.5...3)
        ImageView(withURL: imageURL)
            .frame(width: containerSize.width * viewModel.scale,
                   height: containerSize.height * viewModel.scale)
            .gesture(MagnificationGesture()
                        .onChanged { value in
                            viewModel.magnificationValue = value
                        }
                        .onEnded{ Value in
                            viewModel.endedMagnification()
                        }
                    )
        Text(imageURL.lastPathComponent)
    }
}

struct SingleImageViewGestureState: View {
    var imageURL: URL
    var containerSize: CGSize
        
    @GestureState var scale: CGFloat = 1.0
    
    var body: some View {
        ImageView(withURL: imageURL)
            .frame(width: containerSize.width * scale,
                   height: containerSize.height * scale)
            .gesture(MagnificationGesture()
                    .updating($scale) { currentState, gestureState, transaction in
                        gestureState = currentState
                    }
                    )
        Text(imageURL.lastPathComponent)
    }
}


struct SingleImageView_Previews: PreviewProvider {
    static var previews: some View {
        SingleImageView(imageURL: URL(string: "")!, containerSize: CGSize(width: 0, height: 0))
    }
}
