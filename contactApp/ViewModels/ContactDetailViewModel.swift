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
                self.delegate?.apiSuccess()
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
                self.delegate?.apiSuccess()
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
        if contact != nil { return }
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
        if contact.firstName.isEmpty || contact.firstName.count < 3 {
            delegate?.showAlert(message: "First name not valid")
        } else if contact.lastName.isEmpty || contact.lastName.count < 3 {
            delegate?.showAlert(message: "Last name not valid")
        } else if contact.mobile == nil || contact.mobile!.count < 10 {
            delegate?.showAlert(message: "mobile number not valid")
        } else if contact.email == nil || !contact.email!.isValidEmail {
            delegate?.showAlert(message: "email not valid")
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
