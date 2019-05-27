//
//  ContactEndPoint.swift
//  contactApp
//
//  Created by Mithran Natarajan on 5/23/19.
//  Copyright © 2019 Mithran Natarajan. All rights reserved.
//

import Foundation
public enum ContactApi {
    case getContacts
    case getContact(id: Int)
    case editContact(id: Int, params: Parameters)
    case addContact(params: Parameters)
    case deleteContact(id: Int)
}

extension ContactApi: EndPointType {
    var baseURL: URL {
        guard let url = URL(string: NetworkConstants.BaseURL) else {
            fatalError("baseURL could not be configured.")
        }
        return url
    }

    var path: String {
        switch self {
        case .getContacts:
            return "/contacts.json"
        case let .getContact(id), .editContact(let id, _):
            return "/contacts/\(id).json"
        case .addContact:
            return "/contacts.json"
        case let .deleteContact(id):
            return "/contacts/\(id).json"
        }
    }

    var httpMethod: HTTPMethod {
        switch self {
        case .getContacts, .getContact:
            return .get
        case .addContact:
            return .post
        case .editContact:
            return .put
        case .deleteContact:
            return .delete
        }
    }

    var task: HTTPTask {
        switch self {
        case .getContacts:
            return .requestParameters(bodyParameters: nil, bodyEncoding: .urlEncoding, urlParameters: nil)
        case .getContact:
            return .requestParameters(bodyParameters: nil, bodyEncoding: .urlEncoding, urlParameters: nil)
        case let .addContact(params):
            return .requestParameters(bodyParameters: params, bodyEncoding: .jsonEncoding, urlParameters: nil)
        case let .editContact(_, params):
            return .requestParameters(bodyParameters: params, bodyEncoding: .jsonEncoding, urlParameters: nil)
        case .deleteContact:
            return .requestParameters(bodyParameters: nil, bodyEncoding: .urlEncoding, urlParameters: nil)
        }
    }

    var headers: HTTPHeaders? {
        return nil
    }
}
