//
//  FileEntry.swift
//  SimpleImageViewer
//
//  Created by Gualtiero Frigerio on 05/02/21.
//

import Foundation

/// Describes a filesystem entry
struct FileEntry {
    var isDir:Bool // true if it is a directory
    var isFavorite:Bool = false // true if is part of the user favorites
    var fileURL:URL // full path url string
    var name:String // file/directory name
}

extension FileEntry {
    /// Create a FileEntry from a File at a given path
    /// - Parameter path: String describing the path of the file to read
    /// - Returns: An optional FileEntry constructed from the given file
    static func createFromFileString(_ path:String) -> Self? {
        let absolutePath = path.replacingOccurrences(of: "file://", with: "")
        let fileManager = FileManager.default
        var isDir:ObjCBool = false
        let exists = fileManager.fileExists(atPath: absolutePath, isDirectory: &isDir)
        if exists == false {
            return nil
        }
        let url = URL(fileURLWithPath: absolutePath)
        let name = url.lastPathComponent
        
        return FileEntry(isDir: isDir.boolValue, fileURL: url, name: name)
    }
}

extension FileEntry:Identifiable {
    var id: String {
        name
    }
}

extension FileEntry:Equatable {
    static func ==(lhs:FileEntry, rhs:FileEntry) -> Bool {
        lhs.fileURL.absoluteString == rhs.fileURL.absoluteString
    }
}
