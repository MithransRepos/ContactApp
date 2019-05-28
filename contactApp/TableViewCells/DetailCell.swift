//
//  DetailCell.swift
//  contactApp
//
//  Created by Mithran Natarajan on 5/27/19.
//  Copyright © 2019 Mithran Natarajan. All rights reserved.
//

import UIKit

protocol DetailCellDelegate {
    func textChange(text: String?, tag: Int)
}

class DetailCell: BaseTableViewCell {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var valueTextField: UITextField!
    var delegate: DetailCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setupCell(rowValue: RowValue, tag: Int, editMode: Bool) {
        titleLabel.text = rowValue.title
        valueTextField.text = rowValue.value
        valueTextField.tag = tag
        valueTextField.isUserInteractionEnabled = editMode
    }

    @IBAction func editingChanged(_ sender: UITextField) {
        delegate?.textChange(text: sender.text, tag: sender.tag)
    }
}
