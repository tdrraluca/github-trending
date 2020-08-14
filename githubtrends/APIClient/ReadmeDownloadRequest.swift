//
//  ReadmeDownloadRequest.swift
//  githubtrends
//
//  Created by Raluca Toadere on 14/08/2020.
//  Copyright © 2020 selva. All rights reserved.
//

import Foundation

struct ReadmeDownloadRequest: Request {
    typealias AssociatedResponse = DownloadResponse

    var url: URL
}

struct DownloadResponse: Response {

    let result: String?

    init?(data: Data?) {
        guard let data = data else {
            return nil
        }

        result = String(data: data, encoding: .utf8)
    }
}
