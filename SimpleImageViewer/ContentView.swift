//
//  ContentView.swift
//  SimpleImageViewer
//
//  Created by Gualtiero Frigerio on 03/02/2021.
//

import SwiftUI

let emptyURL = URL(fileURLWithPath: "")

struct ContentView: View {
    @State var imageURL:URL = emptyURL
    
    var body: some View {
         VStack {
            Text("drag an image here")
            ImageView(withURL: imageURL)
        }
        .frame(minWidth: 400, maxWidth: .infinity, minHeight: 400, maxHeight: .infinity)
        .onDrop(of: ["public.file-url"], delegate: self)
    }
}

extension ContentView: DropDelegate {
    func performDrop(info: DropInfo) -> Bool {
        print("performDrop info -> \(info)")
        
        guard let itemProvider = info.itemProviders(for: [(kUTTypeFileURL as String)]).first else { return false }

        itemProvider.loadItem(forTypeIdentifier: (kUTTypeFileURL as String), options: nil) {item, error in
            guard let data = item as? Data,
                  let url = URL(dataRepresentation: data, relativeTo: nil) else { return  }
            self.imageURL = url
        }
        return true
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
