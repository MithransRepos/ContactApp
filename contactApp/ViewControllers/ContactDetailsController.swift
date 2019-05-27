//
//  ContactDetailsController.swift
//  contactApp
//
//  Created by Mithran Natarajan on 5/27/19.
//  Copyright © 2019 Mithran Natarajan. All rights reserved.
//

import UIKit

class ContactDetailsController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - Table view data source

extension ContactDetailsController {
    override func numberOfSections(in _: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
}
extension ContactDetailsController {
    internal static func instantiate() -> ContactDetailsController {
        let storyboard = UIStoryboard(storyboard: .main)
        let _vc: ContactDetailsController = storyboard.instantiateViewController()
        return _vc
    }
}
