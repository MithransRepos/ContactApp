//
//  ContactCell.swift
//  contactApp
//
//  Created by Mithran Natarajan on 5/23/19.
//  Copyright © 2019 Mithran Natarajan. All rights reserved.
//

import UIKit

class ContactCell: BaseTableViewCell {
    @IBOutlet var avatarImageView: UIImageView!
    @IBOutlet var starImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setupCell(contact: Contact) {
        nameLabel.text = contact.firstName
        avatarImageView.setRounded()
        avatarImageView.setImage(from: contact.profilePicUrl)
        starImageView.image = contact.favorite ? .starImage : nil
    }
}
