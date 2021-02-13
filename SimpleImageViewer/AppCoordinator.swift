//
//  AppCoordinator.swift
//  SimpleImageViewer
//
//  Created by Gualtiero Frigerio on 13/02/21.
//

import Foundation

class AppCoordinator {
    private (set) var fileViewModel:FilesViewModel = FilesViewModel()
    
    func setDirectory(_ url:URL) {
        fileViewModel.setDirectory(url)
    }
    
    func showFavorites() {
        
    }
}
