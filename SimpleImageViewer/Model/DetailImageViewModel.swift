//
//  SingleImageViewModel.swift
//  SingleImageViewModel
//
//  Created by Gualtiero Frigerio on 27/08/21.
//

import Foundation

import Foundation
import Combine

/// View model for FilesView
class DetailImageViewModel: ObservableObject {
    @Published var imageURL: URL?
    
    func showImage(atURL url: URL) {
        imageURL = url
    }
}
