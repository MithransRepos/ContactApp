//
//  Contact.swift
//  contactApp
//
//  Created by Mithran Natarajan on 5/23/19.
//  Copyright © 2019 Mithran Natarajan. All rights reserved.
//

import Foundation

// MARK: - Contact

struct Contact: Codable, Equatable {
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

    static func < (lhs: Contact, rhs: Contact) -> Bool {
        return lhs.firstName < rhs.firstName
    }
}

extension Contact {
    var fullName: String {
        return "\(firstName) \(lastName)"
    }

    var profilePicUrl: String {
        if profilePic == "/images/missing.png" {
            return "http://gojek-contacts-app.herokuapp.com\(profilePic)"
        }
        return profilePic
    }
}
