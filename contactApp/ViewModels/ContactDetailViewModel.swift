//
//  ContactDetailViewModel.swift
//  contactApp
//
//  Created by Mithran Natarajan on 5/27/19.
//  Copyright © 2019 Mithran Natarajan. All rights reserved.
//

import Foundation

class ContactDetailViewModel {
    var delegate: ContactsViewModelDelegate?

    private let networkManager: ContactNetworkManager = ContactNetworkManager()

    var contact: Contact! {
        didSet {
            delegate?.reloadData()
        }
    }
}

extension ContactDetailViewModel {
    var isContactLoaded: Bool {
        return contact != nil
    }

    func getContact(id: Int?) {
        guard let id = id else { return }
        delegate?.apiCall(inProgress: true)
        networkManager.getContact(id: id) { result in
            self.delegate?.apiCall(inProgress: false)
            switch result {
            case let .success(response):
                guard let contact = response else { return }
                self.contact = contact
            case .failure:
                break
            }
        }
    }

    func updateFavorite() {
        guard var contactDictionary: Parameters = try? contact.asDictionary() else { return }
        contactDictionary["favorite"] = !contact.favorite
        delegate?.apiCall(inProgress: true)
        networkManager.editContact(id: contact.id, params: contactDictionary) { result in
            self.delegate?.apiCall(inProgress: false)
            switch result {
            case let .success(response):
                guard let contact = response else { return }
                self.contact = contact
            case .failure:
                break
            }
        }
    }
}
