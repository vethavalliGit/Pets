//
//  PetViewModel.swift
//  Pets
//
//  Created by Vetha on 10/11/24.
//

import Foundation
import CoreData
import SwiftUI

class PetViewModel: ObservableObject {
    let viewContext: NSManagedObjectContext
    @Published var pets: [Pet] = []
    
    init(context: NSManagedObjectContext) {
        self.viewContext = context
        fetchPets()
    }
  
    func fetchPets() {
        let request = NSFetchRequest<Pet>(entityName: "Pet")
        
        do {
            pets = try viewContext.fetch(request)
        } catch {
            print("Error fetching pets: \(error)")
        }
    }
    
    func addPet(name: String, species: String, description: String,
                latitude: Double, longitude: Double, photo: UIImage?,
                contactInfo: String, userID: String) {
        let newPet = Pet(context: viewContext)
        newPet.id = UUID()
        newPet.name = name
        newPet.species = species
        newPet.petDescription = description
        newPet.lastSeenLatitude = latitude
        newPet.lastSeenLongitude = longitude
        newPet.photoData = photo?.jpegData(compressionQuality: 0.8)
        newPet.contactInfo = contactInfo
        newPet.dateReported = Date()
        newPet.reportedByUserID = userID
        
        do {
            try viewContext.save()
            fetchPets()
        } catch {
            print("Error saving pet: \(error)")
        }
    }
}
