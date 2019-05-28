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

    var contact: Contact!

    private func updateContact(id: Int, contactDictionary: Parameters) {
        delegate?.apiCall(inProgress: true)
        networkManager.editContact(id: id, params: contactDictionary) { result in
            self.delegate?.apiCall(inProgress: false)
            switch result {
            case let .success(response):
                self.setContact(contact: response)
            case .failure:
                self.delegate?.showAlert(message: "Update contact failed!")
            }
        }
    }

    private func addContact(contactDictionary: Parameters) {
        delegate?.apiCall(inProgress: true)
        networkManager.addContact(params: contactDictionary) { result in
            self.delegate?.apiCall(inProgress: false)
            switch result {
            case let .success(response):
                self.setContact(contact: response)
            case .failure:
                self.delegate?.showAlert(message: "Add contact failed!")
            }
        }
    }

    private func setContact(contact: Contact?) {
        guard let contact = contact else { return }
        self.contact = contact
        delegate?.reloadData()
    }
}

extension ContactDetailViewModel {
    var isContactLoaded: Bool {
        return contact != nil
    }

    func initContact() {
        contact = Contact()
    }

    func firstNameTextChange(text: String) {
        contact.firstName = text
    }

    func lastNameTextChange(text: String) {
        contact.lastName = text
    }

    func mobileTextChange(text: String) {
        contact.mobile = text
    }

    func emailTextChange(text: String) {
        contact.email = text
    }

    func getContact(id: Int?) {
        guard let id = id else { return }
        delegate?.apiCall(inProgress: true)
        networkManager.getContact(id: id) { result in
            self.delegate?.apiCall(inProgress: false)
            switch result {
            case let .success(response):
                self.setContact(contact: response)
            case .failure:
                self.delegate?.showAlert(message: "Couldn't fetch the contact")
            }
        }
    }

    func updateFavorite() {
        guard let id = contact.id else { return }
        guard var contactDictionary: Parameters = try? contact.asDictionary() else { return }
        contactDictionary["favorite"] = !contact.favorite
        updateContact(id: id, contactDictionary: contactDictionary)
    }

    func saveContact() {
        guard let contact = contact else { return }
        if contact.firstName.isEmpty {
            delegate?.showAlert(message: "First name can't be empty")
        } else if contact.lastName.isEmpty {
            delegate?.showAlert(message: "Last name can't be empty")
        } else if contact.mobile == nil || contact.mobile!.isEmpty {
            delegate?.showAlert(message: "mobile can't be empty")
        } else if contact.email == nil || contact.email!.isEmpty {
            delegate?.showAlert(message: "email name can't be empty")
        } else {
            guard let contactDictionary: Parameters = try? contact.asDictionary() else { return }
            guard let id = contact.id else {
                addContact(contactDictionary: contactDictionary)
                return
            }
            updateContact(id: id, contactDictionary: contactDictionary)
        }
    }
}
