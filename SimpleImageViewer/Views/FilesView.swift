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
        List(viewModel.entries) { entry in
            if entry.isDir {
                Button(action:{
                        selectDirectory(entry:entry)}) {
                    SingleEntryView(entry: entry)
                }.buttonStyle(PlainButtonStyle())
            }
            else {
                NavigationLink(
                    destination: SingleImageView(imageURL: entry.fileURL)) {
                    SingleEntryView(entry: entry)
                }
            }
        }
        .onDrop(of: ["public.file-url"], delegate: self)
    }
    
    private func selectDirectory(entry:FileEntry) {
        viewModel.setDirectory(entry.fileURL)
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
