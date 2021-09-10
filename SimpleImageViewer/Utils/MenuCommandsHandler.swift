//
//  MenuCommands.swift
//  SimpleImageViewer
//
//  Created by Gualtiero Frigerio on 09/02/21.
//

import AppKit
import Foundation

/// Handles the execution of commands from the macOS menu
class MenuCommandsHandler {
    /// Initializer
    /// Requires the AppCoordinator to execute commands
    /// - Parameter coordinator: The AppCoordinator
    init(coordinator: AppCoordinator) {
        self.coordinator = coordinator
    }
    
    /// Executed when the open menu voice is clicked
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
                coordinator.setDirectory(url)
            }
        } else {
            print("user cancelled")
            return
        }
    }
    
    /// Executed when the favorites menu voice is clicked
    func showFavoritesCommand() {
        coordinator.showFavorites()
    }
    
    // MARK: - Private
    
    private var coordinator:AppCoordinator
}
