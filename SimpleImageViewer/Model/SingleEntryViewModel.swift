//
//  SingleEntryViewModel.swift
//  SingleEntryViewModel
//
//  Created by Gualtiero Frigerio on 12/09/21.
//

import Foundation
import Combine

class SingleEntryViewModel: ObservableObject {
    var buttonAction: () -> Void
    var entry: FileEntry
    
    init(entry: FileEntry, coordinator: AppCoordinator) {
        self.entry = entry
        self.coordinator = coordinator
        self.buttonAction = {}
        if entry.type != .directory {
            buttonAction = toggleFavorite
        }
    }
    
    private var coordinator: AppCoordinator
    
    private func toggleFavorite() {
        coordinator.toogleFavorite(forFileEntry: entry)
        entry.isFavorite = coordinator.favoritesManager.isFavorite(entry)
        objectWillChange.send()
    }
}
