//
//  FilesViewModel.swift
//  SimpleImageViewer
//
//  Created by Gualtiero Frigerio on 05/02/21.
//

import Foundation

/// View model for FilesView
class FilesViewModel: ObservableObject {
    @Published var entries:[FileEntry] = []
    var supportedExtensions = ["jpg", "png", "heic"]
    
    func setDirectory(_ dir:URL) {
        guard let fileEntries = FilesystemManager.getFileEntries(forDirectory: dir) else { return }
        var entriesToShow = fileEntries.filter(self.filterClosure).sorted(by: self.sortClosure)
        let parentDir = getParentDir(ofDir: dir)
        entriesToShow.insert(parentDir, at: 0)
        DispatchQueue.main.async {
            self.entries = entriesToShow
        }
    }
    
    // MARK: - Private
    
    private func getParentDir(ofDir dir:URL) -> FileEntry {
        let parentURL = dir.deletingLastPathComponent()
        return FileEntry(isDir: true, fileURL: parentURL, name: "..")
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
