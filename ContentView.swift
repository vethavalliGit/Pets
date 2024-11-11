//
//  ContentView.swift
//  Pets
//
//  Created by Vetha on 10/11/24.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @StateObject private var authViewModel = AuthViewModel()
    private let viewContext = PersistenceController.shared.container.viewContext

    var body: some View {
        NavigationView {
            if authViewModel.isAuthenticated {
               
                let petViewModel = PetViewModel(context: viewContext)

                TabView {
                    PetListView(context: viewContext)
                        .tabItem {
                            Label("Missing Pets", systemImage: "pawprint.fill")
                        }
                    
                    AddPetView()
                        .tabItem {
                            Label("Report Missing", systemImage: "plus.circle.fill")
                        }
                    
                    ProfileView(context: viewContext)
                        .tabItem {
                            Label("Profile", systemImage: "person.fill")
                        }
                }
            } else {
                AuthenticationView()
            }
        }
        .environmentObject(authViewModel)
    }
}
