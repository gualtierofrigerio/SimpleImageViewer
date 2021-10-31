//
//  SingleImageViewModel.swift
//  SimpleImageViewer
//
//  Created by Gualtiero Frigerio on 02/10/21.
//

import SwiftUI

class SingleImageViewModel: ObservableObject {
    @Published var magnificationValue: CGFloat = 1.0 {
        didSet {
            updateMagnification(magnificationValue)
        }
    }
    
    @Published var scale: CGFloat = 1.0
    
    @Published var sliderValue: CGFloat = 1.0 {
        didSet {
            updateSlider(sliderValue)
        }
    }
    
    func endedMagnification() {
        withAnimation {
            scale = 1.0
        }
    }
 
    // MARK: - Private
        
    private func updateMagnification(_ value: CGFloat) {
        let adjustedValue = scale * value
        if adjustedValue > 0.5 && adjustedValue < 3 {
            scale = value
            sliderValue = value
        }
    }
    
    private func updateSlider(_ value: CGFloat) {
        if value > 0.5 && value < 3 {
            scale = value
        }
    }
}
