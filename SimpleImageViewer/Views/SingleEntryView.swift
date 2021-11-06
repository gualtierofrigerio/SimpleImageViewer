//
//  SingleEntryView.swift
//  SimpleImageViewer
//
//  Created by Gualtiero Frigerio on 09/02/21.
//

import SwiftUI

struct SingleEntryView: View {
    @ObservedObject var viewModel: SingleEntryViewModel
    
    var body: some View {
        if entry.type == .directory {
            HStack {
                Image(systemName: "folder")
                    .font(.largeTitle)
                Text(entry.name)
            }
        }
        else {
            HStack {
                ThumbnailView(withURL: entry.fileURL, maxSize: 200)
                Text(entry.name)
                Button(action: viewModel.buttonAction, label: {
                    Image(systemName:favoriteImageName)
                }).buttonStyle(PlainButtonStyle())
            }
        }
    }
    
    private var entry: FileEntry {
        viewModel.entry
    }
    
    private var favoriteImageName:String {
        entry.isFavorite == true ? "star.fill" : "star"
    }
}

