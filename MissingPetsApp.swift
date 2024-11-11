//
//  MissingPetsApp.swift
//  Pets
//
//  Created by Vetha on 10/11/24.
//

import SwiftUI

@main
struct MissingPetsApp: App {
    let persistenceController = PersistenceController.shared
    @StateObject private var authViewModel = AuthViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(authViewModel)
        }
    }
}
