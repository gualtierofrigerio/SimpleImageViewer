//
//  MenuCommands.swift
//  SimpleImageViewer
//
//  Created by Gualtiero Frigerio on 08/02/21.
//

import SwiftUI

struct MenuCommands: Commands {
    var commandsHandler:MenuCommandsHandler
    
    var body: some Commands {
        CommandGroup(replacing: CommandGroupPlacement.newItem) {
            // replace with nothing so we don't have to deal with multiple windows
        }
        CommandGroup(after: CommandGroupPlacement.newItem) {
            Button("Open...") {
                commandsHandler.openCommand()
            }
            Button("Show Favorites") {
                commandsHandler.showFavoritesCommand()
            }
        }
    }
}

