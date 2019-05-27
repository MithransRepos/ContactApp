//
//  ContactDetailViewModel.swift
//  contactApp
//
//  Created by Mithran Natarajan on 5/27/19.
//  Copyright © 2019 Mithran Natarajan. All rights reserved.
//

import Foundation

protocol ContactDetailViewModelDelegate {
    func reloadData()
}

class ContactDetailViewModel {
    var contact: Contact!
    var delegate: ContactDetailViewModelDelegate?

    private let networkManager: ContactNetworkManager = ContactNetworkManager()

    init(contact: Contact) {
        self.contact = contact
    }

    func updateFavorite() {
        guard var contactDictionary: Parameters = try? contact.asDictionary() else { return }
        contactDictionary["favorite"] = !contact.favorite
        networkManager.editContact(id: contact.id, params: contactDictionary) { result in
            switch result {
            case let .success(response):
                guard let contact = response else { return }
                self.contact = contact
                self.delegate?.reloadData()
            case .failure:
                break
            }
        }
    }
}
