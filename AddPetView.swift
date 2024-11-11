//
//  AddPetView.swift
//  Pets
//
//  Created by Vetha on 10/11/24.
//

import Foundation
import SwiftUI
import MapKit
import PhotosUI

struct AddPetView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var authViewModel: AuthViewModel
    @StateObject private var locationManager = LocationManager()
    
    @State private var name = ""
    @State private var species = ""
    @State private var description = ""
    @State private var contactInfo = ""
    @State private var selectedPhoto: PhotosPickerItem?
    @State private var selectedPhotoData: Data?
    @State private var showingPhotoPicker = false
    @State private var showingAlert = false
    @State private var alertMessage = ""
    
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    )
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Pet Information")) {
                    TextField("Pet Name", text: $name)
                    TextField("Species", text: $species)
                    TextField("Description", text: $description, axis: .vertical)
                        .lineLimit(3...6)
                }
                
                Section(header: Text("Photo")) {
                    PhotosPicker(selection: $selectedPhoto) {
                        if let selectedPhotoData,
                           let uiImage = UIImage(data: selectedPhotoData) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 200)
                        } else {
                            Label("Select Photo", systemImage: "photo")
                        }
                    }
                }
                
                Section(header: Text("Last Seen Location")) {
                    Map(coordinateRegion: $region)
                        .frame(height: 200)
                        .onTapGesture { coordinate in
                            // Handle map tap to set location
                        }
                }
                
                Section(header: Text("Contact Information")) {
                    TextField("Contact Details", text: $contactInfo)
                }
                
                Button("Report Missing Pet") {
                    submitReport()
                }
                .disabled(!isFormValid)
            }
            .navigationTitle("Report Missing Pet")
            .alert("Error", isPresented: $showingAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(alertMessage)
            }
            .onChange(of: selectedPhoto) { newValue in
                Task {
                    if let data = try? await newValue?.loadTransferable(type: Data.self) {
                        selectedPhotoData = data
                    }
                }
            }
        }
    }
    
    private var isFormValid: Bool {
        !name.isEmpty && !species.isEmpty && !description.isEmpty &&
        !contactInfo.isEmpty && selectedPhotoData != nil
    }
    
    private func submitReport() {
        guard let user = authViewModel.currentUser else {
            alertMessage = "Please sign in to report a missing pet"
            showingAlert = true
            return
        }
        
        let viewModel = PetViewModel(context: viewContext)
        viewModel.addPet(
            name: name,
            species: species,
            description: description,
            latitude: region.center.latitude,
            longitude: region.center.longitude,
            photo: selectedPhotoData.flatMap(UIImage.init(data:)),
            contactInfo: contactInfo,
            userID: user.id
        )
        
        // Reset form
        name = ""
        species = ""
        description = ""
        contactInfo = ""
        selectedPhoto = nil
        selectedPhotoData = nil
    }
}
