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

    func setupCell(rowValue: RowValue, editMode: Bool) {
        titleLabel.text = rowValue.title
        valueTextField.text = rowValue.value
        valueTextField.isUserInteractionEnabled = editMode
    }
}
