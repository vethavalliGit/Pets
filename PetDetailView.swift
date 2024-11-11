//
//  PetDetailView.swift
//  Pets
//
//  Created by Vetha on 10/11/24.
//

import Foundation
import SwiftUI
import MapKit

struct PetDetailView: View {
    let pet: Pet
    @State private var region: MKCoordinateRegion
    
    init(pet: Pet) {
        self.pet = pet
        let coordinate = CLLocationCoordinate2D(
            latitude: pet.lastSeenLatitude,
            longitude: pet.lastSeenLongitude
        )
        _region = State(initialValue: MKCoordinateRegion(
            center: coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        ))
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                if let photoData = pet.photoData,
                   let uiImage = UIImage(data: photoData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                        .frame(maxHeight: 300)
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text(pet.name ?? "Unknown")
                        .font(.title)
                        .bold()
                    
                    Text(pet.species ?? "Unknown Species")
                        .font(.headline)
                        .foregroundColor(.secondary)
                    
                    Text(pet.petDescription ?? "")
                        .padding(.vertical)
                    
                    Text("Last Seen Location")
                        .font(.headline)
                    
                    Map(coordinateRegion: $region, annotationItems: [pet]) { pet in
                        MapMarker(coordinate: CLLocationCoordinate2D(
                            latitude: pet.lastSeenLatitude,
                            longitude: pet.lastSeenLongitude
                        ))
                    }
                    .frame(height: 200)
                    .cornerRadius(10)
                    
                    Text("Contact Information")
                        .font(.headline)
                    Text(pet.contactInfo ?? "")
                    
                    Text("Date Reported: \(pet.dateReported?.formatted() ?? "")")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                .padding()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}
