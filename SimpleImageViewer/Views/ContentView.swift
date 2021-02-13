//
//  ContentView.swift
//  SimpleImageViewer
//
//  Created by Gualtiero Frigerio on 03/02/2021.
//

import SwiftUI

struct ContentView: View {
    var coordinator:AppCoordinator
    
    var body: some View {
        NavigationView {
            VStack {
                FilesView(coordinator: coordinator)
            }
        }
        .frame(minWidth: 400, maxWidth: .infinity, minHeight: 400, maxHeight: .infinity)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(coordinator: AppCoordinator())
    }
}
