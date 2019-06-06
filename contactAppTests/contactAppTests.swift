//
//  contactAppTests.swift
//  contactAppTests
//
//  Created by Mithran Natarajan on 5/22/19.
//  Copyright © 2019 Mithran Natarajan. All rights reserved.
//

@testable import contactApp
import XCTest

class contactAppTests: XCTestCase {
   
    func testContactsApi() {
        ContactNetworkManager().getContacts { (result) in
            switch result {
            case .success(let response):
                XCTAssertNotNil(response)
            case .failure(_):
                break
            }
        }
    }
}
