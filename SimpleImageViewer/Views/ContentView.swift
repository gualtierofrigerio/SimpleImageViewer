//
//  ContentView.swift
//  SimpleImageViewer
//
//  Created by Gualtiero Frigerio on 03/02/2021.
//

import SwiftUI

struct ContentView: View {
    var filesViewModel:FilesViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                FilesView(viewModel: filesViewModel)
            }
        }
        .frame(minWidth: 400, maxWidth: .infinity, minHeight: 400, maxHeight: .infinity)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(filesViewModel: FilesViewModel())
    }
}
