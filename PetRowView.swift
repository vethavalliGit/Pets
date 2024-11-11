//
//  PetRowView.swift
//  Pets
//
//  Created by Vetha on 10/11/24.
//

import Foundation
import SwiftUI

struct PetRowView: View {
    let pet: Pet
    
    var body: some View {
        HStack {
            if let photoData = pet.photoData,
               let uiImage = UIImage(data: photoData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 60, height: 60)
                    .clipShape(Circle())
            }
            
            VStack(alignment: .leading) {
                Text(pet.name ?? "Unknown")
                    .font(.headline)
                Text(pet.species ?? "Unknown Species")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
    }
}
