//
//  UIViewControllerExtension.swift
//  contactApp
//
//  Created by Mithran Natarajan on 5/24/19.
//  Copyright © 2019 Mithran Natarajan. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func setTitle(title _: String) {
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.appBlack, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .semibold)]
        title = "Contact"
    }
}
