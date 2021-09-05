//
//  DropUtils.swift
//  SimpleImageViewer
//
//  Created by Gualtiero Frigerio on 05/02/21.
//

import Foundation
import SwiftUI

/// Implements the drag and drop functionallity 
class DropUtils {
    class func urlFromDropInfo(_ info:DropInfo, completion: @escaping (URL?) -> Void)  {
        guard let itemProvider = info.itemProviders(for: [(kUTTypeFileURL as String)]).first else {
            completion(nil)
            return
        }

        itemProvider.loadItem(forTypeIdentifier: (kUTTypeFileURL as String), options: nil) {item, error in
            guard let data = item as? Data,
                  let url = URL(dataRepresentation: data, relativeTo: nil) else {
                completion(nil)
                return
            }
            completion(url)
        }
    }
}
