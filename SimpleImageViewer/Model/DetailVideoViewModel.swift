//
//  DetailVideoViewModel.swift
//  SimpleImageViewer
//
//  Created by Gualtiero Frigerio on 01/11/21.
//

import Foundation

class DetailVideoViewModel: ObservableObject {
    @Published var videoURL: URL?
    
    func showVideo(atURL url: URL) {
        videoURL = url
    }
}
