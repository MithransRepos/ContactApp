//
//  ContactsViewModel.swift
//  contactApp
//
//  Created by Mithran Natarajan on 5/23/19.
//  Copyright © 2019 Mithran Natarajan. All rights reserved.
//

import Foundation

protocol ContactsViewModelDelegate {
    func showAlert(message: String)
    func apiCall(inProgress: Bool)
    func reloadData()
}

class ContactsViewModel {
    private let networkManager: ContactNetworkManager = ContactNetworkManager()
    private var contactDictionary: [String: [Contact]] = [:]
    var contactTitles: [String] = [] {
        didSet {
            delegate?.reloadData()
        }
    }

    var delegate: ContactsViewModelDelegate?

    private func indexContacts(contacts: [Contact]) {
        for contact in contacts {
            guard let firstLetter = contact.firstName.first?.uppercased() else { return }
            if var contacts: [Contact] = contactDictionary[firstLetter] {
                let index = contacts.insertionIndexOf(elem: contact) { $0 < $1 } // Or: myArray.indexOf(c, <)
                contacts.insert(contact, at: index)
                contactDictionary[firstLetter] = contacts
            } else {
                contactDictionary[firstLetter] = [contact]
            }
        }
        contactTitles = contactDictionary.keys.sorted()
    }

    private func getContacts(for section: Int) -> [Contact]? {
        let title = contactTitles[section]
        guard let contacts = contactDictionary[title] else { return nil }
        return contacts
    }
}

extension ContactsViewModel {
    func getContacts() {
        delegate?.apiCall(inProgress: true)
        networkManager.getContacts { result in
            self.delegate?.apiCall(inProgress: false)
            switch result {
            case let .success(contacts):
                guard let contacts = contacts else { return }
                self.indexContacts(contacts: contacts)
            case .failure:
                self.delegate?.showAlert(message: "Coundn't get contacts")
            }
        }
    }

    var titleCount: Int {
        return contactTitles.count
    }

    func getTitle(at index: Int) -> String {
        return contactTitles[index]
    }

    func noOfContacts(for section: Int) -> Int {
        return getContacts(for: section)?.count ?? 0
    }

    func getContact(for section: Int, at index: Int) -> Contact? {
        guard let contacts = getContacts(for: section) else { return nil }
        return contacts[index]
    }
}
