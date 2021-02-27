//
//  FilesView.swift
//  SimpleImageViewer
//
//  Created by Gualtiero Frigerio on 05/02/21.
//

import SwiftUI

struct FilesView: View {
    @ObservedObject var viewModel:FilesViewModel
    @State var openImage = false
    
    init(coordinator:AppCoordinator) {
        self.coordinator = coordinator
        self.viewModel = coordinator.filesViewModel
    }
    
    var body: some View {
        //listView() // uncomment to use old implementation with List
        NavigationLink(destination: SingleImageView(imageURL:selectedImageURL), isActive: $openImage){}.hidden()
        ScrollView {
            LazyVStack(alignment: .leading) {
                ForEach(viewModel.entries) { entry in
                    if entry.isDir {
                        Button(action:{
                                selectDirectory(entry:entry)}) {
                            SingleEntryView(buttonAction:emptyAction, entry: entry)
                        }.buttonStyle(PlainButtonStyle())
                    }
                    else {
                        Button(action: {
                            self.selectedImageURL = entry.fileURL
                            self.openImage = true
                        }) {
                            SingleEntryView(buttonAction:{
                                toggleFavorite(entry)
                            }, entry: entry)
                            .frame(width:nil, height:250)
                        }.buttonStyle(PlainButtonStyle())
                    }
                }
            }
        }
        .onDrop(of: ["public.file-url"], delegate: self)
    }
    
    // MARK: - Private
    private var coordinator:AppCoordinator
    private var emptyAction:() -> Void = {} // used on dir entries as you don't need an action
    @State private var selectedImageURL:URL = URL(string:"url")!
    
    private func selectDirectory(entry:FileEntry) {
        coordinator.setDirectory(entry.fileURL)
    }
    
    private func toggleFavorite(_ entry:FileEntry) {
        coordinator.toogleFavorite(forFileEntry: entry)
    }
}

// old implementation with List and NavigationLink
extension FilesView {
    private func listView() -> some View {
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
