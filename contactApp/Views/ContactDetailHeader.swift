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
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        initView()
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        initView()
//    }
//
//    override func awakeFromNib() {
//        super.awakeFromNib()
//    }
//
//    private func initView() {
//        Bundle.main.loadNibNamed(String(describing: ContactDetailHeader.self), owner: self, options: nil)
//        contentView.frame = bounds
//        addSubview(contentView)
//        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
//    }

    func setupView(contact: Contact) {
        avatarImageView.setImage(from: contact.profilePicUrl)
        avatarImageView.setBorder(withColor: .white, borderWidth: 2)
        nameLabel.text = contact.firstName
        favoriteImageView.image = contact.favorite ? UIImage.favorite : UIImage.notfavorite
    }
}

extension ContactDetailHeader: ReusableView, NibLoadableView {}
