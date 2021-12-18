//
//  FilesView.swift
//  SimpleImageViewer
//
//  Created by Gualtiero Frigerio on 05/02/21.
//

import SwiftUI

struct FilesView: View {
    @ObservedObject var viewModel: FilesViewModel
    @State var alwaysActive = true
    @State var imageActive = false
    @State var videoActive = false
    
    init(coordinator:AppCoordinator) {
        self.coordinator = coordinator
        self.viewModel = coordinator.filesViewModel
    }
    
    // MARK: - View
    
    var body: some View {
        NavigationLink(destination: DetailImageView(viewModel: coordinator.detailImageViewModel),
                       isActive: $imageActive){}.hidden()
        NavigationLink(destination: DetailVideoView(viewModel: coordinator.detailVideoViewModel),
                       isActive: $videoActive){}.hidden()
        if noEntries {
            Text("Drag a folder here")
        }
        else {
            sortingView
        }
        ScrollView {
            LazyVStack(alignment: .leading) {
                ForEach(viewModel.entries) { entry in
                    view(forEntry: entry)
                }
            }
        }
        .onDrop(of: ["public.file-url"], delegate: self)
    }
    
    private var sortingView: some View {
        HStack {
            Picker(selection: $viewModel.orderBy, label: Text("Order by")) {
                Text("File name").tag(FilesOrder.name)
                Text("Modified date").tag(FilesOrder.modificationDate)
            }.pickerStyle(.segmented)
            Button(action:{
                viewModel.orderAscending.toggle()
            }
            ) {
                if viewModel.orderAscending {
                    Image(systemName: "arrow.up")
                }
                else {
                    Image(systemName: "arrow.down")
                }
            }.buttonStyle(PlainButtonStyle())
        }
    }
    
    @ViewBuilder private func view(forEntry entry: FileEntry) -> some View {
        switch entry.type {
        case .directory:
            Button(action:{
                selectDirectory(entry:entry)}) {
                    SingleEntryView(viewModel: viewModel(forEntry: entry))
                }.buttonStyle(PlainButtonStyle())
        case .image:
            Button(action: {
                coordinator.showImage(atURL: entry.fileURL)
                imageActive = true
            }) {
                SingleEntryView(viewModel: viewModel(forEntry: entry))
                    .frame(width:nil, height:250)
            }.buttonStyle(PlainButtonStyle())
        case .video:
            Button(action: {
                coordinator.showVideo(atURL: entry.fileURL)
                videoActive = true
            }) {
                SingleEntryView(viewModel: viewModel(forEntry: entry))
                    .frame(width:nil, height:250)
            }.buttonStyle(PlainButtonStyle())
        }
    }
    
    // MARK: - Private
    
    private var coordinator: AppCoordinator
    private var emptyAction: () -> Void = {} // used on dir entries as you don't need an action
    
    private var noEntries: Bool {
        viewModel.entries.count == 0
    }
    
    private func selectDirectory(entry: FileEntry) {
        coordinator.setDirectory(entry.fileURL)
    }
    
    private func toggleFavorite(_ entry: FileEntry) {
        coordinator.toogleFavorite(forFileEntry: entry)
    }
    
    private func viewModel(forEntry entry: FileEntry) -> SingleEntryViewModel {
        SingleEntryViewModel(entry: entry, coordinator: coordinator)
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
