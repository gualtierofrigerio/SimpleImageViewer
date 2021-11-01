//
//  DetailVideoView.swift
//  SimpleImageViewer
//
//  Created by Gualtiero Frigerio on 01/11/21.
//

import AVKit
import SwiftUI

struct DetailVideoView: View {
    @ObservedObject var viewModel: DetailVideoViewModel
    
    var body: some View {
        if let url = viewModel.videoURL {
            VideoPlayer(player: AVPlayer(url: url))
        }
        else {
            Text("Select a video on the left")
        }
    }
}

struct DetailVideoView_Previews: PreviewProvider {
    static var previews: some View {
        DetailVideoView(viewModel: DetailVideoViewModel())
    }
}
