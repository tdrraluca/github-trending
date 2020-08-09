//
//  APIClient.swift
//  githubtrends
//
//  Created by Raluca Toadere on 07/08/2020.
//  Copyright © 2020 selva. All rights reserved.
//

import Foundation
import Alamofire

class APIClient {

    func perform<T: Request>(request: T, completion: @escaping (Result<T.AssociatedResponse, APIClient.Error>) -> Void) {
        let httpMethod = alamofireHTTPMethod(from: request.httpMethod)
        let encoding = alamofireParameterEncoding(for: request.contentType)

        let headers: Alamofire.HTTPHeaders? = request.headers.map( { return Alamofire.HTTPHeaders($0) })

        AF.request(request.url,
                          method: httpMethod,
                          parameters: request.parameters,
                          encoding: encoding,
                          headers: headers)
                .validate(statusCode: 200..<300)
                .responseData { response in

            switch response.result {
            case .success:
                if let response = T.AssociatedResponse.init(data: response.data) {
                    completion(.success(response))
                } else {
                    completion(.failure(APIClient.Error.responseDecodingError))
                }
            case .failure(let afError):
                switch afError {
                case .responseValidationFailed(let reason):
                    if case let .unacceptableStatusCode(code) = reason {
                        completion(.failure(.httpError(statusCode: code)))
                        return
                    }
                case .parameterEncodingFailed:
                    completion(.failure(.parameterEncodingError))
                    return
                default:
                    completion(.failure(.other(afError.localizedDescription)))
                }
            }
        }
    }

    private func alamofireHTTPMethod(from httpMethod: HTTPMethod) -> Alamofire.HTTPMethod {
        switch httpMethod {
        case .get:
            return .get
        case .post:
            return .post
        }
    }

    private func alamofireParameterEncoding(for contentType: ContentType) -> Alamofire.ParameterEncoding {
        switch contentType {
        case .JSON:
            return Alamofire.JSONEncoding.default
        case .URLEncoded:
            return Alamofire.URLEncoding.default
        }
    }
}

extension APIClient {
    enum Error: LocalizedError {
        case httpError(statusCode: Int)
        case parameterEncodingError
        case responseDecodingError
        case other(String)

        var localizedDescription: String {
            switch self {
            case .httpError(let code):
                return "HTTP error \(code)"
            case .parameterEncodingError:
                return "Parameters encoding error"
            case .responseDecodingError:
                return "The received response cannot be decoded"
            case .other(let message):
                return message
            }
        }

        var errorDescription: String? { return localizedDescription }
    }
}
