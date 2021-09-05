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
/// calling showImage sets a @Published var that forces the update of the view
class DetailImageViewModel: ObservableObject {
    @Published var imageURL: URL?
    
    /// Loads an image forcing the view to show it
    /// - Parameter url: the image url
    func showImage(atURL url: URL) {
        imageURL = url
    }
}
