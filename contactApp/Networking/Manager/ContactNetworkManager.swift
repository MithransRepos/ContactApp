//
//  ContactNetworkManager.swift
//  contactApp
//
//  Created by Mithran Natarajan on 5/23/19.
//  Copyright © 2019 Mithran Natarajan. All rights reserved.
//

import Foundation
class ContactNetworkManager {
    private let router = Router<ContactApi>()
    
    func getContacts(completion: @escaping (Result<[Contact]?, APIError>) -> Void) {
        router.fetch(.getContacts, decode: { json -> [Contact]? in
            json as? [Contact]
        }, completion: completion)
    }
    
    func getContact(id: Int, completion: @escaping (Result<Contact?, APIError>) -> Void) {
        router.fetch(.getContact(id: id), decode: { json -> Contact? in
            json as? Contact
        }, completion: completion)
    }
    
    func editContact(id: Int, params: Parameters, completion: @escaping (Result<Contact?, APIError>) -> Void) {
        router.fetch(.editContact(id: id, params: params), decode: { json -> Contact? in
            json as? Contact
        }, completion: completion)
    }
    
    func deleleteContact(id: Int, completion: @escaping (Result<Contact?, APIError>) -> Void) {
        router.fetch(.getContact(id: id), decode: { json -> Contact? in
            json as? Contact
        }, completion: completion)
    }
    
}
