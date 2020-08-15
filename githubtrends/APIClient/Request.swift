//
//  Request.swift
//  githubtrends
//
//  Created by Raluca Toadere on 07/08/2020.
//  Copyright © 2020 selva. All rights reserved.
//

import Foundation

enum HTTPMethod {
    case get
    case post
}

enum ParameterEncoding {
    case JSON
    case URLEncoded
}

protocol Request {
    associatedtype AssociatedResponse: Response

    var url: URL { get }

    var httpMethod: HTTPMethod { get }

    var parameters: [String: Any]? { get }

    var parameterEncoding: ParameterEncoding { get }

    var headers: [String: String]? { get }
}

extension Request {

    var httpMethod: HTTPMethod {
        return .get
    }

    var parameters: [String: Any]? {
        return nil
    }

    var parameterEncoding: ParameterEncoding {
        return .JSON
    }

    var headers: [String: String]? {
        return nil
    }
}

protocol Response {
    init?(data: Data?)
}
