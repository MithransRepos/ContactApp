//
//  ContactDetailHeader.swift
//  contactApp
//
//  Created by Mithran Natarajan on 5/27/19.
//  Copyright © 2019 Mithran Natarajan. All rights reserved.
//

import UIKit

class ContactDetailHeader: UITableViewHeaderFooterView {
    @IBOutlet var avatarImageView: UIImageView!
    @IBOutlet var messageView: UIView!
    @IBOutlet var callView: UIView!
    @IBOutlet var emailView: UIView!
    @IBOutlet var favoriteView: UIView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var favoriteImageView: UIImageView!

    func setupView(contact: Contact) {
        favoriteImageView.setRounded()
        avatarImageView.setImage(from: contact.profilePicUrl)
        avatarImageView.setBorder(withColor: .white, borderWidth: 2)
        nameLabel.text = contact.firstName
        favoriteImageView.image = contact.favorite ? UIImage.favorite : UIImage.notfavorite
    }
}

extension ContactDetailHeader: ReusableView, NibLoadableView {}
