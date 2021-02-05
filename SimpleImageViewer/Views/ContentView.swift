//
//  ContentView.swift
//  SimpleImageViewer
//
//  Created by Gualtiero Frigerio on 03/02/2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            FilesView(viewModel: FilesViewModel())
        }
        .frame(minWidth: 400, maxWidth: .infinity, minHeight: 400, maxHeight: .infinity)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}