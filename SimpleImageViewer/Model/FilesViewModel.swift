//
//  FilesViewModel.swift
//  SimpleImageViewer
//
//  Created by Gualtiero Frigerio on 05/02/21.
//

import Foundation

class FilesViewModel: ObservableObject {
    @Published var entries:[FileEntry] = []
    var supportedExtensions = ["jpg", "png", "heic"]
    
    func setDirectory(_ dir:URL) {
        guard let fileEntries = FilesystemManager.getFileEntries(forDirectory: dir) else { return }
        DispatchQueue.main.async {
            self.entries = fileEntries.filter(self.filterClosure).sorted(by: self.sortClosure)
        }
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
