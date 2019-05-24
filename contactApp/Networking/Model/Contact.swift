//
//  Contact.swift
//  contactApp
//
//  Created by Mithran Natarajan on 5/23/19.
//  Copyright © 2019 Mithran Natarajan. All rights reserved.
//

import Foundation

// MARK: - Contact

struct Contact: Codable {
    let id: Int
    let firstName, lastName, profilePic: String
    let favorite: Bool
    let url: String

    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case profilePic = "profile_pic"
        case favorite, url
    }
}
