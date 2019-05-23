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
        viewModel.delegate = self
    }

}

// MARK: - Table view data source
extension ContactsController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.titleCount
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.noOfContacts(for: section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value2, reuseIdentifier: "cellId")
        let contact = viewModel.getContact(for: indexPath.section, at: indexPath.row)
        cell.detailTextLabel?.text = contact?.firstName
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.getTitle(at: section)
    }

    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return viewModel.contactTitles
    }
}

extension ContactsController: ContactsViewModelDelegate {
    
    func reloadData() {
        tableView.reloadData()
    }
}
