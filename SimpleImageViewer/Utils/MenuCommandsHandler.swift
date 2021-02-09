//
//  MenuCommands.swift
//  SimpleImageViewer
//
//  Created by Gualtiero Frigerio on 09/02/21.
//

import AppKit
import Foundation

class MenuCommandsHandler {
    var filesViewModel:FilesViewModel
    
    init(withFilesViewModel filesViewModel:FilesViewModel) {
        self.filesViewModel = filesViewModel
    }
    
    func openCommand() {
        let dialog = NSOpenPanel();

        dialog.title                    = "Choose a directory"
        dialog.showsResizeIndicator     = true
        dialog.showsHiddenFiles         = false
        dialog.allowsMultipleSelection  = false
        dialog.canChooseDirectories     = true
        dialog.canChooseFiles           = false

        if (dialog.runModal() ==  NSApplication.ModalResponse.OK) {
            if let url = dialog.url {
                filesViewModel.setDirectory(url)
            }
        } else {
            print("user cancelled")
            return
        }
    }
}
