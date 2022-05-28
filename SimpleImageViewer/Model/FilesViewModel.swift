//
//  FilesViewModel.swift
//  SimpleImageViewer
//
//  Created by Gualtiero Frigerio on 05/02/21.
//

import Foundation
import Combine
import SwiftUI

enum FilesOrder {
    case name
    case modificationDate
}

/// View model for FilesView
class FilesViewModel: ObservableObject {
    @Published var entries: [FileEntry] = []
    @Published var orderBy: FilesOrder = .name {
        didSet {
            sortEntries()
        }
    }
    @Published var orderAscending = true {
        didSet {
            sortEntries()
        }
    }
    var scrollViewProxy: ScrollViewProxy?
    var scrollViewTopId: String = "_scroll_view_top_id_"
    
    var supportedExtensions = ["jpg", "jpeg", "png", "heic", "mov"]
    
    init(favoritesManager: FavoritesManager) {
        self.favoritesManager = favoritesManager
        favoritesCancellable = favoritesManager.$favorites.sink { _ in
            self.updateEntries(self.entries)
        }
    }
    
    /// Sets the current directory and updates the entries variable
    /// so the view objserving entries can be updated
    /// - Parameter dir: URL of the directory
    func setDirectory(_ dir: URL) {
        guard let fileEntries = FilesystemManager.getFileEntries(forDirectory: dir) else { return }
        var entriesToShow = fileEntries
            .filter(filterClosure)
            .sorted(by: sortClosure)
        let parentDir = getParentDir(ofDir: dir)
        entriesToShow.insert(parentDir, at: 0)
        updateEntries(entriesToShow)
    }
    
    /// Updates the entries variable in the main thread
    /// - Parameter entries: array of FileEntry that will be set to entries
    func updateEntries(_ entries:[FileEntry]) {
        DispatchQueue.main.async {
            self.entries = entries.map(self.favoritesClosure)
            self.scrollViewProxy?.scrollTo(self.scrollViewTopId, anchor: .top)
        }
    }
    
    // MARK: - Private
    
    private var favoritesCancellable:AnyCancellable?
    private var favoritesManager:FavoritesManager
    
    private func getParentDir(ofDir dir:URL) -> FileEntry {
        let parentURL = dir.deletingLastPathComponent()
        return FileEntry(type: .directory,
                         fileURL: parentURL,
                         name: "..",
                         modificationDate: Date())
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
        if entry.type == .directory {
            keep = true
        }
        let fileExtention = entry.fileURL.pathExtension.lowercased()
        if supportedExtensions.contains(fileExtention) {
            keep = true
        }
        return keep
    }
    
    private func sortClosure(lhs:FileEntry, rhs:FileEntry) -> Bool {
        // internal function to sort two entries
        func sortEntries(lhs:FileEntry, rhs:FileEntry) -> Bool {
            if orderBy == .name {
                if orderAscending {
                    return lhs.name.lowercased() < rhs.name.lowercased()
                }
                else {
                    return lhs.name.lowercased() > rhs.name.lowercased()
                }
            }
            else {
                if orderAscending {
                    return lhs.modificationDate < rhs.modificationDate
                }
                else {
                    return lhs.modificationDate > rhs.modificationDate
                }
            }
        }
        
        if (lhs.type == rhs.type) ||
            (lhs.type != .directory && rhs.type != .directory) {
            return sortEntries(lhs: lhs, rhs: rhs)
        }
        else {
            return lhs.type == .directory
        }
    }
    
    private func sortEntries() {
        let sortedEntries = entries.sorted(by: sortClosure)
        updateEntries(sortedEntries)
    }
}
