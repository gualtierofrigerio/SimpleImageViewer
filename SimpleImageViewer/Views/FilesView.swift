//
//  FilesView.swift
//  SimpleImageViewer
//
//  Created by Gualtiero Frigerio on 05/02/21.
//

import SwiftUI

struct FilesView: View {
    @ObservedObject var viewModel:FilesViewModel
    
    init(coordinator:AppCoordinator) {
        self.coordinator = coordinator
        self.viewModel = coordinator.filesViewModel
    }
    
    var body: some View {
        List(viewModel.entries) { entry in
            if entry.isDir {
                Button(action:{
                        selectDirectory(entry:entry)}) {
                    SingleEntryView(buttonAction:emptyAction, entry: entry)
                }.buttonStyle(PlainButtonStyle())
            }
            else {
                NavigationLink(
                    destination: SingleImageView(imageURL: entry.fileURL)) {
                    SingleEntryView(buttonAction:{
                        toggleFavorite(entry)
                    }, entry: entry)
                }
            }
        }
        .onDrop(of: ["public.file-url"], delegate: self)
    }
    
    // MARK: - Private
    private var coordinator:AppCoordinator
    private var emptyAction:() -> Void = {} // used on dir entries as you don't need an action
    
    private func selectDirectory(entry:FileEntry) {
        viewModel.setDirectory(entry.fileURL)
    }
    
    private func toggleFavorite(_ entry:FileEntry) {
        coordinator.toogleFavorite(forFileEntry: entry)
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
        FilesView(coordinator:AppCoordinator())
    }
}
