//
//  FilesViewModel.swift
//  SimpleImageViewer
//
//  Created by Gualtiero Frigerio on 05/02/21.
//

import Foundation
import Combine

/// View model for FilesView
class FilesViewModel: ObservableObject {
    @Published var entries:[FileEntry] = []
    var supportedExtensions = ["jpg", "png", "heic"]
    
    init(favoritesManager: FavoritesManager) {
        self.favoritesManager = favoritesManager
        favoritesCancellable = favoritesManager.$favorites.sink { _ in
            self.updateEntries(self.entries)
        }
    }
    
    func setDirectory(_ dir:URL) {
        guard let fileEntries = FilesystemManager.getFileEntries(forDirectory: dir) else { return }
        var entriesToShow = fileEntries
            .filter(filterClosure)
            .sorted(by: sortClosure)
        let parentDir = getParentDir(ofDir: dir)
        entriesToShow.insert(parentDir, at: 0)
        updateEntries(entriesToShow)
    }
    
    func updateEntries(_ entries:[FileEntry]) {
        DispatchQueue.main.async {
            self.entries = entries.map(self.favoritesClosure)
        }
    }
    
    // MARK: - Private
    
    private var favoritesCancellable:AnyCancellable?
    private var favoritesManager:FavoritesManager
    
    private func getParentDir(ofDir dir:URL) -> FileEntry {
        let parentURL = dir.deletingLastPathComponent()
        return FileEntry(isDir: true, fileURL: parentURL, name: "..")
    }
    
    private func favoritesClosure(entry:FileEntry) -> FileEntry {
        var newEntry = entry
        newEntry.isFavorite = favoritesManager.isFavorite(entry)
        if newEntry.isFavorite {
            print("new entry is favorite")
        }
        return newEntry
    }
    
    private func filterClosure(entry:FileEntry) -> Bool {
        var keep = false
        if entry.isDir {
            keep = true
        }
        let fileExtention = entry.fileURL.pathExtension.lowercased()
        if supportedExtensions.contains(fileExtention) {
            keep = true
        }
        return keep
    }
    
    private func sortClosure(lhs:FileEntry, rhs:FileEntry) -> Bool {
        if lhs.isDir == rhs.isDir {
            return lhs.name.lowercased() < rhs.name.lowercased()
        }
        else {
            return lhs.isDir
        }
    }
}
