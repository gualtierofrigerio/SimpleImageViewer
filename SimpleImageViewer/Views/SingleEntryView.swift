//
//  SingleEntryView.swift
//  SimpleImageViewer
//
//  Created by Gualtiero Frigerio on 09/02/21.
//

import SwiftUI

struct SingleEntryView: View {
    var buttonAction:() -> Void
    var entry:FileEntry
    
    var body: some View {
        if entry.isDir {
            HStack {
                Image(systemName: "folder")
                    .font(.largeTitle)
                Text(entry.name)
            }
        }
        else {
            HStack {
                ImageView(withURL: entry.fileURL, maxSize:300)
                Text(entry.name)
                Button(action: buttonAction, label: {
                    Image(systemName:favoriteImageName)
                }).buttonStyle(PlainButtonStyle())
            }
        }
    }
    
    private var favoriteImageName:String {
        entry.isFavorite == true ? "star.fill" : "star"
    }
}

