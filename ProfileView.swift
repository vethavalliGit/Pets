//
//  ProfileView.swift
//  Pets
//
//  Created by Vetha on 10/11/24.
//

import SwiftUI
import CoreData

struct ProfileView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @Environment(\.managedObjectContext) private var viewContext
    @StateObject private var petViewModel: PetViewModel
    
    init(context: NSManagedObjectContext) {
        _petViewModel = StateObject(wrappedValue: PetViewModel(context: context))
    }
    
    var userReportedPets: [Pet] {
        petViewModel.pets.filter { pet in
            pet.reportedByUserID == authViewModel.currentUser?.id
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("User Information")) {
                    if let user = authViewModel.currentUser {
                        HStack {
                            Text("Email")
                            Spacer()
                            Text(user.email)
                                .foregroundColor(.secondary)
                        }
                    }
                }
                
                Section(header: Text("Your Reported Pets")) {
                    if userReportedPets.isEmpty {
                        Text("No pets reported")
                            .foregroundColor(.secondary)
                    } else {
                        ForEach(userReportedPets) { pet in
                            NavigationLink(destination: PetDetailView(pet: pet)) {
                                PetRowView(pet: pet)
                            }
                        }
                    }
                }
                
                Section {
                    Button(action: {
                        authViewModel.signOut()
                    }) {
                        HStack {
                            Text("Sign Out")
                                .foregroundColor(.red)
                            Spacer()
                            Image(systemName: "arrow.right.square")
                                .foregroundColor(.red)
                        }
                    }
                }
            }
            .navigationTitle("Profile")
        }
    }
}

