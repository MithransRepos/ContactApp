//
//  ContactsController.swift
//  contactApp
//
//  Created by Mithran Natarajan on 5/23/19.
//  Copyright © 2019 Mithran Natarajan. All rights reserved.
//

import UIKit

class ContactsController: UITableViewController {
    let viewModel = ContactsViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupController()
    }

    private func setupController() {
        setTitle(title: "Contact")
        setupAddNavigationButton()
        setupTableView()
        viewModel.delegate = self
        viewModel.getContacts()
    }

    private func setupTableView() {
        tableView.sectionIndexColor = UIColor.lightGray
        tableView.register(ContactCell.self)
        tableView.tableFooterView = UIView()
    }

    private func setupAddNavigationButton() {
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addContact))
        barButtonItem.tintColor = .appgreen
        navigationItem.rightBarButtonItem = barButtonItem
    }

    @objc private func addContact() {}
}

// MARK: - Table view data source

extension ContactsController {
    override func numberOfSections(in _: UITableView) -> Int {
        return viewModel.titleCount
    }

    override func tableView(_: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.noOfContacts(for: section)
    }

    override func tableView(_: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.getTitle(at: section)
    }

    override func tableView(_: UITableView, willDisplayHeaderView view: UIView, forSection _: Int) {
        view.tintColor = .headerGrey
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = .appBlack
        header.textLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
    }

    override func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        return 64
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ContactCell = tableView.dequeueReusableCell(for: indexPath) as ContactCell
        if let contact = viewModel.getContact(for: indexPath.section, at: indexPath.row) {
            cell.setupCell(contact: contact)
        }
        return cell
    }

    override func sectionIndexTitles(for _: UITableView) -> [String]? {
        return viewModel.contactTitles
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let contactDetailsController = ContactDetailsController.instantiate()
        self.navigationController?.pushViewController(contactDetailsController, animated: true)
    }
}

extension ContactsController: ContactsViewModelDelegate {
    func apiCall(inProgress: Bool) {
        inProgress ? showLoader() : hideLoader()
    }

    func reloadData() {
        tableView.reloadData()
    }
}
