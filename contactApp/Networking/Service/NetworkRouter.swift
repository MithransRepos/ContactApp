//
//  NetworkRouter.swift
//  contactApp
//
//  Created by Mithran Natarajan on 5/23/19.
//  Copyright © 2019 Mithran Natarajan. All rights reserved.
//

import Foundation

protocol NetworkRouter: AnyObject {
    associatedtype EndPoint: EndPointType
    func fetch<T: Decodable>(_ route: EndPoint, decode: @escaping (Decodable) -> T?, completion: @escaping (Result<T, APIError>) -> Void)
    func cancel()
}

enum APIError: Error {
    case requestFailed
    case jsonConversionFailure
    case invalidData
    case responseUnsuccessful
    case jsonParsingFailure
    case serverErrorResponse(message: String)
    case emptyCache

    var localizedDescription: String {
        switch self {
        case .requestFailed: return "Something went wrong"
        case .invalidData: return "Invalid Data"
        case .responseUnsuccessful: return "Something went wrong"
        case .jsonParsingFailure: return "JSON Parsing Failure"
        case .jsonConversionFailure: return "JSON Conversion Failure"
        case let .serverErrorResponse(message):
            return message
        case .emptyCache: return "Not found in local Cache."
        }
    }
}
