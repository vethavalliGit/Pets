//
//  User.swift
//  Pets
//
//  Created by Vetha on 10/11/24.
//

import Foundation


struct User: Identifiable, Codable {
    let id: String
    let email: String
    var isLoggedIn: Bool
}
