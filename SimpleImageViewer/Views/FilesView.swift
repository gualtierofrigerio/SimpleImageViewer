//
//  FilesView.swift
//  SimpleImageViewer
//
//  Created by Gualtiero Frigerio on 05/02/21.
//

import SwiftUI

struct FilesView: View {
    @ObservedObject var viewModel:FilesViewModel
    
    var body: some View {
        NavigationView {
            List(viewModel.entries) { entry in
                NavigationLink(
                    destination: SingleImageView(imageURL: entry.fileURL)) {
                        SingleEntryView(entry: entry)
                    }
            }
        }
        .onDrop(of: ["public.file-url"], delegate: self)
    }
}

struct SingleEntryView: View {
    var entry:FileEntry
    
    var body: some View {
        if entry.isDir {
            HStack {
                if #available(OSX 11.0, *) {
                    Image(systemName: "folder").font(.largeTitle)
                } else {
                    Text("FOLDER")
                }
                Text(entry.name)
            }
        }
        else {
            HStack {
                ImageView(withURL: entry.fileURL)
                Text(entry.name)
            }
        }
    }
}

extension FilesView:DropDelegate {
    func performDrop(info: DropInfo) -> Bool {
        DropUtils.urlFromDropInfo(info) { url in
            if let url = url {
                viewModel.setDirectory(url)
            }
        }
        return true
    }
}

struct FileView_Previews: PreviewProvider {
    static var previews: some View {
        FilesView(viewModel:FilesViewModel())
    }
}
