//
//  RepoReadMeRequest.swift
//  githubtrends
//
//  Created by Raluca Toadere on 14/08/2020.
//  Copyright © 2020 selva. All rights reserved.
//

import Foundation

struct RepoReadmeRequest: Request {
    typealias AssociatedResponse = RepoReadmeResponse

    private let author: String
    private let name: String

    init(author: String, name: String) {
        self.author = author
        self.name = name
    }

    var url: URL {
        let urlString = "https://api.github.com/repos/\(author)/\(name)/readme"
        return URL(string: urlString)!
    }
}

struct RepoReadmeResponse: Response {

    let result: URL?

    init?(data: Data?) {
        guard let data = data else {
            return nil
        }

        do {
            result = (try JSONDecoder().decode(APIModel.RepoReadme.self, from: data)).downloadURL
        } catch {
            return nil
        }
    }
}
