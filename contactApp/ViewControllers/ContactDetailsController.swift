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

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = .appGreen
        setupTableView()
    }

    private func setupTableView() {
        let header = ContactDetailHeader(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 332))
        header.setupView(contact: viewModel.contact)
        tableView.tableHeaderView = header
        tableView.estimatedRowHeight = 56
        tableView.tableFooterView = UIView()
    }
}

// MARK: - Table view data source

extension ContactDetailsController {
    override func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: DetailCell = tableView.dequeueReusableCell(for: indexPath) as DetailCell
        return cell
    }
}

extension ContactDetailsController {
    internal static func instantiate(contact: Contact) -> ContactDetailsController {
        let storyboard = UIStoryboard(storyboard: .main)
        let _vc: ContactDetailsController = storyboard.instantiateViewController()
        _vc.viewModel = ContactDetailViewModel(contact: contact)
        return _vc
    }
}
