//
//  File.swift
//  SimpleImageViewer
//
//  Created by Gualtiero Frigerio on 18/02/21.
//

import Foundation

class AppCoordinator {
    private (set) var filesViewModel:FilesViewModel
    
    init() {
        filesViewModel = FilesViewModel(favoritesManager: favoritesManager)
    }
    
    func setDirectory(_ url:URL) {
        filesViewModel.setDirectory(url)
    }
    
    func showFavorites() {
        let allFavorites = favoritesManager.favorites.compactMap {
            FileEntry.createFromFileString($0)
        }
        filesViewModel.updateEntries(allFavorites)
    }
    
    func toogleFavorite(forFileEntry entry:FileEntry) {
        favoritesManager.toggle(fileEntry: entry)
    }
    
    private var favoritesManager:FavoritesManager = FavoritesManager()
}
