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
    @Published var currentZoomDisplay: String = "100 %"
    
    @Published var stepperValue: Int = 1 {
        didSet {
            singleImageViewModel.scale = 1.0 + CGFloat(stepperValue) / 10
        }
    }
    
    // TODO: - find a better solution to handle this as an optional or initialize it without a URL
    var singleImageViewModel: SingleImageViewModel = SingleImageViewModel(imageURL: URL(string: "https://google.com")!)
    
    /// Loads an image forcing the view to show it
    /// - Parameter url: the image url
    func showImage(atURL url: URL) {
        imageURL = url
        singleImageViewModel = SingleImageViewModel(imageURL: url)
        cancellable = singleImageViewModel.$scale.sink { value in
            self.updateZoom(withScale: value)
        }
    }

    // MARK: - Private
    
    private var cancellable: AnyCancellable?
    
    private func updateZoom(withScale scale: CGFloat) {
        currentZoomDisplay = String(format: "%.2f", scale * 100) + " %"
    }
}
