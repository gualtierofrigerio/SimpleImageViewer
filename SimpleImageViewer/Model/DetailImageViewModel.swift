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
            if let singleImageViewModel = singleImageViewModel {
                singleImageViewModel.scale = 1.0 + CGFloat(stepperValue) / 10
            }
        }
    }
    
    var singleImageViewModel: SingleImageViewModel?
    
    /// Loads an image forcing the view to show it
    /// - Parameter url: the image url
    func showImage(atURL url: URL) {
        imageURL = url
        let imageVM = SingleImageViewModel(imageURL: url)
        singleImageViewModel = imageVM
        cancellable = imageVM.$scale.sink { value in
            self.updateZoom(withScale: value)
        }
    }

    // MARK: - Private
    
    private var cancellable: AnyCancellable?
    
    private func updateZoom(withScale scale: CGFloat) {
        currentZoomDisplay = String(format: "%.2f", scale * 100) + " %"
    }
}
