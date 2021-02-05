//
//  FileEntry.swift
//  SimpleImageViewer
//
//  Created by Gualtiero Frigerio on 05/02/21.
//

import Foundation

struct FileEntry {
    var isDir:Bool
    var fileURL:URL
    var name:String
}

extension FileEntry:Identifiable {
    var id: String {
        name
    }
}
