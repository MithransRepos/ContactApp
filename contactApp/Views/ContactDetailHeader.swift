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
    @IBOutlet var stackView: UIStackView!

    override func awakeFromNib() {
        avatarImageView.setRounded()
        avatarImageView.setBorder(withColor: .lightGray, borderWidth: 2)
    }

    func setupView(contact: Contact) {
        favoriteImageView.setRounded()
        avatarImageView.setImage(from: contact.profilePicUrl)
        nameLabel.text = contact.firstName
        favoriteImageView.image = contact.favorite ? UIImage.favorite : UIImage.notfavorite
    }

    func hideStackView() {
        stackView.isHidden = true
    }
}

extension ContactDetailHeader: ReusableView, NibLoadableView {}
