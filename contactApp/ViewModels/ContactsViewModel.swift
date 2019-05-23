//
//  ContactsViewModel.swift
//  contactApp
//
//  Created by Mithran Natarajan on 5/23/19.
//  Copyright © 2019 Mithran Natarajan. All rights reserved.
//

import Foundation

protocol ContactsViewModelDelegate {
    func reloadData()
}

class ContactsViewModel {
    
    private let networkManager: ContactNetworkManager = ContactNetworkManager()
    private var contacts: [Contact] = []
    var delegate: ContactsViewModelDelegate?
    
    init() {
        getContacts()
    }
    
    private func getContacts() {
        networkManager.getContacts { (result) in
            switch result{
            case .success(let contacts):
                guard let contacts = contacts else { return }
                self.contacts = contacts
            case .failure(_):
                break
            }
        }
    }
    
}
extension ContactsViewModel {
    
    var contactCount:  Int {
        return contacts.count
    }
    
    func getContact(at index: Int) -> Contact{
        return contacts[index]
    }
}
