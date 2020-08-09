//
//  TrendingRepoRequest.swift
//  githubtrends
//
//  Created by Raluca Toadere on 07/08/2020.
//  Copyright © 2020 selva. All rights reserved.
//

import Foundation

struct TrendingRepoRequest: Request {
    typealias AssociatedResponse = TrendingRepoResponse

    var url: URL {
        return URL(string: "https://ghapi.huchen.dev/repositories?since=weekly")!
    }
}

struct TrendingRepoResponse: Response {

    let result: [APIModel.RepoPreview]

    init?(data: Data?) {
        guard let data = data else {
            return nil
        }
        do {
            result = try JSONDecoder().decode([APIModel.RepoPreview].self, from: data)
        } catch {
            return nil
        }
    }
}
