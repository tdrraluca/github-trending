//
//  RepoListWorker.swift
//  githubtrends
//
//  Created by Raluca Toadere on 07/08/2020.
//  Copyright © 2020 selva. All rights reserved.
//

import Foundation

class RepoListWorker {
    func retrieveAPITrendingRepos(completion: @escaping(Result<[APIModel.RepoPreview], APIClient.Error>) -> Void) {
        APIClient().perform(request: TrendingRepoRequest()) { result in
            switch result {
            case .success(let response):
                let repos = response.result
                completion(.success(repos))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func downloadReadme(url: URL, completion: @escaping(Result<String, APIClient.Error>) -> Void) {

    }
}
