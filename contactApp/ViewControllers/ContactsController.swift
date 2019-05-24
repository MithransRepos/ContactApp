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
        viewModel.delegate = self
        tableView.sectionIndexColor = UIColor.lightGray
        tableView.register(ContactCell.self)
    }
}

// MARK: - Table view data source

extension ContactsController {
    override func numberOfSections(in _: UITableView) -> Int {
        return viewModel.titleCount
    }

    override func tableView(_: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.noOfContacts(for: section)
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

    override func tableView(_: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.getTitle(at: section)
    }

    override func sectionIndexTitles(for _: UITableView) -> [String]? {
        return viewModel.contactTitles
    }
}

extension ContactsController: ContactsViewModelDelegate {
    func reloadData() {
        tableView.reloadData()
    }
}
