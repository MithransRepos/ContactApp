//
//  ContactDetailsController.swift
//  contactApp
//
//  Created by Mithran Natarajan on 5/27/19.
//  Copyright © 2019 Mithran Natarajan. All rights reserved.
//

import UIKit
typealias RowValue = (title: String, value: String?)
class ContactDetailsController: UITableViewController {
    let viewModel: ContactDetailViewModel = ContactDetailViewModel()
    var mode: Mode = .view
    var contactId: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
        setupNavigation()
        setupTableView()
    }

    private func setupViewModel() {
        viewModel.delegate = self
        if mode == .add {
            viewModel.initContact()
        } else {
            viewModel.getContact(id: contactId)
        }
    }

    private func setupNavigation() {
        navigationController?.navigationBar.tintColor = .appGreen
        if isModal {
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(dismissControllerAnimatted))
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneTapped))
        } else {
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editTapped))
        }
    }

    private func setupTableView() {
        hideKeyboardOnTouchOutside()
        tableView.tableFooterView = UIView()
        tableView.register(ContactDetailHeader.self)
    }

    @objc func editTapped() {
        let contactDetailsController = ContactDetailsController.instantiate(id: contactId, mode: .edit)
        let navController = UINavigationController(rootViewController: contactDetailsController)
        navigationController?.present(navController, animated: false, completion: nil)
    }

    @objc func doneTapped() {
        viewModel.saveContact()
    }
}

// MARK: - Table view data source

extension ContactDetailsController {
    override func numberOfSections(in _: UITableView) -> Int {
        return (viewModel.isContactLoaded || mode == .add) ? 1 : 0
    }

    override func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        switch mode {
        case .add, .edit:
            return EditableFields.allCases.count
        case .view:
            return DisplayFields.allCases.count
        }
    }

    override func tableView(_: UITableView, heightForHeaderInSection _: Int) -> CGFloat {
        switch mode {
        case .add, .edit:
            return 262
        case .view:
            return 335
        }
    }

    override func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        return 56
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection _: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(ContactDetailHeader.self) as ContactDetailHeader
        switch mode {
        case .add, .edit:
            header.hideStackView()
        case .view:
            header.setupView(contact: viewModel.contact)
        }
        header.favoriteView.addTapGestureRecognizer {
            self.viewModel.updateFavorite()
        }
        return header
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: DetailCell = tableView.dequeueReusableCell(for: indexPath) as DetailCell
        cell.delegate = self
        let editMode = mode == .add || mode == .edit
        switch mode {
        case .add, .edit:
            let enumRow: EditableFields = EditableFields(rawValue: indexPath.row)!
            cell.setupCell(rowValue: enumRow.getTitleValue(contact: viewModel.contact), tag: indexPath.row, editMode: editMode)
        case .view:
            let enumRow: DisplayFields = DisplayFields(rawValue: indexPath.row)!
            cell.setupCell(rowValue: enumRow.getTitleValue(contact: viewModel.contact), tag: indexPath.row, editMode: editMode)
        }
        return cell
    }
}

extension ContactDetailsController {
    internal static func instantiate(id: Int? = nil, mode: Mode = .view) -> ContactDetailsController {
        let storyboard = UIStoryboard(storyboard: .main)
        let _vc: ContactDetailsController = storyboard.instantiateViewController()
        _vc.contactId = id
        _vc.mode = mode
        return _vc
    }
}

extension ContactDetailsController {
    enum Mode {
        case add
        case edit
        case view
    }

    enum EditableFields: Int, CaseIterable {
        case firstName
        case lastName
        case mobile
        case email

        func getTitleValue(contact: Contact?) -> RowValue {
            switch self {
            case .firstName:
                return ("First Name", contact?.firstName)
            case .lastName:
                return ("Last Name", contact?.lastName)
            case .mobile:
                return ("mobile", contact?.mobile)
            case .email:
                return ("email", contact?.email)
            }
        }
    }

    enum DisplayFields: Int, CaseIterable {
        case email
        case mobile

        func getTitleValue(contact: Contact) -> RowValue {
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
    func showAlert(message: String) {
        showAlert(alertTitle: nil, alertMessage: message)
    }

    func apiCall(inProgress: Bool) {
        inProgress ? showLoader() : hideLoader()
    }

    func reloadData() {
        tableView.reloadData()
    }
}

extension ContactDetailsController: DetailCellDelegate {
    func textChange(text: String?, tag: Int) {
        guard let text = text else { return }
        if let field: EditableFields = EditableFields(rawValue: tag) {
            switch field {
            case .firstName:
                viewModel.firstNameTextChange(text: text)
            case .lastName:
                viewModel.lastNameTextChange(text: text)
            case .mobile:
                viewModel.mobileTextChange(text: text)
            case .email:
                viewModel.emailTextChange(text: text)
            }
        }
    }
}
