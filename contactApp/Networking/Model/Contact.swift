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
    var id: Int?
    var firstName, lastName, profilePic: String
    var favorite: Bool
    var url: String?
    var email: String?
    var mobile: String?

    init() {
        firstName = ""
        lastName = ""
        profilePic = ""
        favorite = false
    }

    enum CodingKeys: String, CodingKey {
        case id, email
        case firstName = "first_name"
        case lastName = "last_name"
        case profilePic = "profile_pic"
        case mobile = "phone_number"
        case favorite, url
    }

    static func < (lhs: Contact, rhs: Contact) -> Bool {
        return lhs.firstName.capitalized < rhs.firstName.capitalized
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
