//
//  ContactDetailsController.swift
//  contactApp
//
//  Created by Mithran Natarajan on 5/27/19.
//  Copyright © 2019 Mithran Natarajan. All rights reserved.
//

import UIKit

class ContactDetailsController: UITableViewController {
    let viewModel: ContactDetailViewModel = ContactDetailViewModel()
    var editMode: Bool = false
    var contactId: Int!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = .appGreen
        navigationItem.rightBarButtonItem = editButtonItem
        viewModel.delegate = self
        viewModel.getContact(id: contactId)
        setupTableView()
    }

    private func setupTableView() {
        tableView.estimatedRowHeight = 56
        tableView.tableFooterView = UIView()
        tableView.register(ContactDetailHeader.self)
    }
}

// MARK: - Table view data source

extension ContactDetailsController {
    override func numberOfSections(in _: UITableView) -> Int {
        return viewModel.isContactLoaded ? 1 : 0
    }

    override func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return editMode ? EditableFields.allCases.count : DisplayFields.allCases.count
    }

    override func tableView(_: UITableView, heightForHeaderInSection _: Int) -> CGFloat {
        return 335
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection _: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(ContactDetailHeader.self) as ContactDetailHeader
        header.setupView(contact: viewModel.contact)
        header.favoriteView.addTapGestureRecognizer {
            self.viewModel.updateFavorite()
        }
        return header
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: DetailCell = tableView.dequeueReusableCell(for: indexPath) as DetailCell
        var titleValue: (title: String, value: String?)!
        if editMode {
            let enumRow: EditableFields = EditableFields(rawValue: indexPath.row)!
            titleValue = enumRow.getTitleValue(contact: viewModel.contact)
        } else {
            let enumRow: DisplayFields = DisplayFields(rawValue: indexPath.row)!
            titleValue = enumRow.getTitleValue(contact: viewModel.contact)
        }
        cell.setupCell(title: titleValue.title, value: titleValue.value, editMode: editMode)
        return cell
    }
}

extension ContactDetailsController {
    internal static func instantiate(id: Int, editMode: Bool = false) -> ContactDetailsController {
        let storyboard = UIStoryboard(storyboard: .main)
        let _vc: ContactDetailsController = storyboard.instantiateViewController()
        _vc.contactId = id
        _vc.editMode = editMode
        return _vc
    }
}

extension ContactDetailsController {
    enum EditableFields: Int, CaseIterable {
        case firstName
        case lastName
        case mobile
        case email

        func getTitleValue(contact: Contact) -> (title: String, value: String?) {
            switch self {
            case .firstName:
                return ("First Name", contact.firstName)
            case .lastName:
                return ("Last Name", contact.lastName)
            case .mobile:
                return ("mobile", contact.mobile)
            case .email:
                return ("email", contact.email)
            }
        }
    }

    enum DisplayFields: Int, CaseIterable {
        case email
        case mobile

        func getTitleValue(contact: Contact) -> (title: String, value: String?) {
            switch self {
            case .mobile:
                return ("mobile", contact.mobile)
            case .email:
                return ("email", contact.email)
            }
        }
    }
}

extension ContactDetailsController: ContactsViewModelDelegate {
    func apiCall(inProgress: Bool) {
        inProgress ? showLoader() : hideLoader()
    }

    func reloadData() {
        tableView.reloadData()
    }
}
