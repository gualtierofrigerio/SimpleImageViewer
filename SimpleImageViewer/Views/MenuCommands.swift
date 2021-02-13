//
//  MenuCommands.swift
//  SimpleImageViewer
//
//  Created by Gualtiero Frigerio on 08/02/21.
//

import SwiftUI

struct MenuCommands {
    var commandsHandler:MenuCommandsHandler
    
    var commands: some Commands {
        CommandGroup(after: CommandGroupPlacement.newItem) {
            Button("Open...") {
                commandsHandler.openCommand()
            }
            Button("Show Favorites") {
                commandsHandler.showFavorites()
            }
        }
    }
}

