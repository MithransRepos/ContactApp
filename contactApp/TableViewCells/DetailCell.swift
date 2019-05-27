//
//  DetailCell.swift
//  contactApp
//
//  Created by Mithran Natarajan on 5/27/19.
//  Copyright © 2019 Mithran Natarajan. All rights reserved.
//

import UIKit

class DetailCell: BaseTableViewCell {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var valueTextField: UITextField!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupCell(title: String, value: String?, editMode: Bool) {
        titleLabel.text = title
        valueTextField.text = value
        valueTextField.isUserInteractionEnabled = editMode
    }
}
