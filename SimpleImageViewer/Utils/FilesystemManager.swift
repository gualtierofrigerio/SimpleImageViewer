//
//  FilesystemManager.swift
//  SimpleImageViewer
//
//  Created by Gualtiero Frigerio on 05/02/21.
//

import Foundation

class FilesystemManager {
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
            let entry = FileEntry(isDir: isDir, fileURL: item, name: name)
            entries.append(entry)
        }
        return entries
    }
}
