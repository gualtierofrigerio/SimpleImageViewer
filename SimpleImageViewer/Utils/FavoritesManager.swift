//
//  FavoritesManager.swift
//  SimpleImageViewer
//
//  Created by Gualtiero Frigerio on 13/02/21.
//

import Foundation
import Combine

class FavoritesManager {
    @Published var favorites:[String] = []
    
    init() {
        load()
    }
    
    func add(fileEntry:FileEntry) {
        favorites.append(fileEntry.fileURL.absoluteString)
        save()
    }
    
    func isFavorite(_ entry:FileEntry) -> Bool {
        favorites.contains(entry.fileURL.absoluteString)
    }
    
    func remove(fileEntry:FileEntry) {
        favorites.removeAll(where: {$0 == fileEntry.fileURL.absoluteString})
        save()
    }
    
    func toggle(fileEntry:FileEntry) {
        if favorites.contains(fileEntry.fileURL.absoluteString) {
            remove(fileEntry: fileEntry)
        }
        else {
            add(fileEntry: fileEntry)
        }
    }
    
    // MARK: - Private
    
    
    private func load() {
        let defaults = UserDefaults.standard
        if let fileEntries = defaults.object(forKey: "favorites") as? [String] {
            favorites = fileEntries
        }
    }
    
    private func save() {
        let defaults = UserDefaults.standard
        defaults.setValue(favorites, forKey: "favorites")
    }
}
