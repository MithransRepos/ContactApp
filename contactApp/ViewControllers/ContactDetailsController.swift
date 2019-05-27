//
//  ContactDetailsController.swift
//  contactApp
//
//  Created by Mithran Natarajan on 5/27/19.
//  Copyright © 2019 Mithran Natarajan. All rights reserved.
//

import UIKit

class ContactDetailsController: UITableViewController {
    var viewModel: ContactDetailViewModel!
    var editMode: Bool = false
    var header: ContactDetailHeader!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = .appGreen
        navigationItem.rightBarButtonItem = editButtonItem
        viewModel.delegate = self
        setupHeader()
        setupTableView()
    }

    private func setupHeader() {
        header = ContactDetailHeader(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 335))
        header.setupView(contact: viewModel.contact)
        tableView.tableHeaderView = header

        header.favoriteView.addTapGestureRecognizer {
            self.viewModel.updateFavorite()
        }
    }

    private func setupTableView() {
        tableView.estimatedRowHeight = 56
        tableView.tableFooterView = UIView()
    }
}

// MARK: - Table view data source

extension ContactDetailsController {
    override func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return editMode ? EditableFields.allCases.count : DisplayFields.allCases.count
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
    internal static func instantiate(contact: Contact, editMode: Bool = false) -> ContactDetailsController {
        let storyboard = UIStoryboard(storyboard: .main)
        let _vc: ContactDetailsController = storyboard.instantiateViewController()
        _vc.editMode = editMode
        _vc.viewModel = ContactDetailViewModel(contact: contact)
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

extension ContactDetailsController: ContactDetailViewModelDelegate {
    func reloadData() {
        header.setupView(contact: viewModel.contact)
        tableView.reloadData()
    }
}
