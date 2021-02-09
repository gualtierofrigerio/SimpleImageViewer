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
    var fileURL:URL // full path url
    var name:String // file/directory name
}

extension FileEntry:Identifiable {
    var id: String {
        name
    }
}
