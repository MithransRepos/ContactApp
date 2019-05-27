//
//  ContactDetailHeader.swift
//  contactApp
//
//  Created by Mithran Natarajan on 5/27/19.
//  Copyright © 2019 Mithran Natarajan. All rights reserved.
//

import UIKit

class ContactDetailHeader: UIView {
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var callView: UIView!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var favoriteView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var favoriteImageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initView()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    private func initView() {
        Bundle.main.loadNibNamed(String(describing: ContactDetailHeader.self), owner: self, options: nil)
        contentView.frame = bounds
        addSubview(contentView)
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }

    func setupView(contact: Contact) {
        avatarImageView.setImage(from: contact.profilePicUrl)
        avatarImageView.setBorder(withColor: .white, borderWidth: 2)
        nameLabel.text = contact.firstName
        favoriteImageView.image = contact.favorite ? UIImage.favorite : UIImage.notfavorite
    }
}
