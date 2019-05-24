//
//  UIImageViewExtension.swift
//  contactApp
//
//  Created by Mithran Natarajan on 5/24/19.
//  Copyright © 2019 Mithran Natarajan. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    func setImage(from url: URL, withPlaceholder placeholder: UIImage? = nil) {
        image = placeholder
        URLSession.shared.dataTask(with: url) { data, _, _ in
            if let data = data {
                let image = UIImage(data: data)
                DispatchQueue.main.async {
                    self.image = image
                }
            }
        }.resume()
    }
}
