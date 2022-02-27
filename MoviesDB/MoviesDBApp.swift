//
//  MoviesDBApp.swift
//  MoviesDB
//
//  Created by Vijaychandran Jayachandran on 26/2/22.
//

import SwiftUI

@main
struct MoviesDBApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            MoviesListView(vm: MoviesListViewModel())
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
