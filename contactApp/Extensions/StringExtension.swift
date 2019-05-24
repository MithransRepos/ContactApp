//
//  StringExtension.swift
//  contactApp
//
//  Created by Mithran Natarajan on 5/24/19.
//  Copyright © 2019 Mithran Natarajan. All rights reserved.
//

import Foundation

extension String {
    func getGoJekImageUrl() -> String {
        if self == "/images/missing.png" {
            return "http://gojek-contacts-app.herokuapp.com\(self)"
        }
        return self
    }

    func contains(find: String) -> Bool {
        return range(of: find) != nil
    }

    func containsIgnoringCase(find: String) -> Bool {
        return range(of: find, options: .caseInsensitive) != nil
    }
}
