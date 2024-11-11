//
//  PetListView.swift
//  Pets
//
//  Created by Vetha on 10/11/24.
//

import Foundation
import SwiftUI
import MapKit
import CoreData

struct PetListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @StateObject private var viewModel: PetViewModel
    @State private var searchText = ""
    @State private var selectedSpecies: String?
    
    init(context: NSManagedObjectContext) {
        _viewModel = StateObject(wrappedValue: PetViewModel(context: context))
    }
    
    var filteredPets: [Pet] {
        viewModel.pets.filter { pet in
            let matchesSearch = searchText.isEmpty ||
                pet.name?.localizedCaseInsensitiveContains(searchText) == true ||
                pet.species?.localizedCaseInsensitiveContains(searchText) == true
            
            let matchesSpecies = selectedSpecies == nil || pet.species == selectedSpecies
            
            return matchesSearch && matchesSpecies
        }
    }
    
    var body: some View {
        List {
            ForEach(filteredPets) { pet in
                NavigationLink(destination: PetDetailView(pet: pet)) {
                    PetRowView(pet: pet)
                }
            }
        }
        .searchable(text: $searchText)
        .navigationTitle("Missing Pets")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Menu("Filter") {
                    Button("All", action: { selectedSpecies = nil })
                    Button("Dogs", action: { selectedSpecies = "Dog" })
                    Button("Cats", action: { selectedSpecies = "Cat" })
                }
            }
        }
    }
}
