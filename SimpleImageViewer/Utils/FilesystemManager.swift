//
//  FilesystemManager.swift
//  SimpleImageViewer
//
//  Created by Gualtiero Frigerio on 05/02/21.
//

import Foundation

/// Helper class to manage files
class FilesystemManager {
    /// Reads files into a directory and returns an array of FileEntry
    /// - Parameter dir: URL of the directory to scan
    /// - Returns: An optional array of FileEntry
    static func getFileEntries(forDirectory dir:URL) -> [FileEntry]? {
        let fileManager = FileManager()
        guard let items = try? fileManager.contentsOfDirectory(at: dir,
                                                               includingPropertiesForKeys: nil,
                                                               options: .skipsSubdirectoryDescendants) else {
            return nil
        }
        var entries:[FileEntry] = []
        for item in items {
            let name = item.lastPathComponent
            let isDir = item.hasDirectoryPath
            let isVideo = item.pathExtension.lowercased() == "mov"
            let entry = FileEntry(isDir: isDir, isVideo: isVideo, fileURL: item, name: name)
            entries.append(entry)
        }
        return entries
    }
}
