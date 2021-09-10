//
//  FavoritesManager.swift
//  SimpleImageViewer
//
//  Created by Gualtiero Frigerio on 13/02/21.
//

import Foundation
import Combine

/// Utility class to manage favorites
class FavoritesManager {
    /// This array of String can be observed to show a list of favorites
    @Published var favorites:[String] = []
    
    init() {
        load()
    }
    
    /// Add a FileEntry to the favorites
    /// - Parameter fileEntry: The FileEntry to add
    func add(fileEntry:FileEntry) {
        favorites.append(fileEntry.fileURL.absoluteString)
        save()
    }
    
    /// Check if a FileEntry is favorite
    /// - Parameter entry: The FileEntry to check
    /// - Returns: true if the entry is favorite
    func isFavorite(_ entry:FileEntry) -> Bool {
        favorites.contains(entry.fileURL.absoluteString)
    }
    
    /// Remove a FileEntry from favorites
    /// - Parameter fileEntry: The FileEntry to remove
    func remove(fileEntry:FileEntry) {
        favorites.removeAll(where: {$0 == fileEntry.fileURL.absoluteString})
        save()
    }
    
    /// Toggle the favorite status for a FileEntry
    /// - Parameter fileEntry: The FileEntry to toggle
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
