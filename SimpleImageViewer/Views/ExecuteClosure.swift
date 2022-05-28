//
//  ExecuteClosure.swift
//  SimpleImageViewer
//
//  Created by Gualtiero Frigerio on 08/01/22.
//

import SwiftUI

struct ExecuteClosure: View {
    init( _ closure: () -> ()) {
        closure()
    }
    
    var body: some View {
        EmptyView()
    }
}

struct ExecuteClosure_Previews: PreviewProvider {
    static var previews: some View {
        ExecuteClosure({})
    }
}
