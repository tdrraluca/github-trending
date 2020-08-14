//
//  RepoReadmeWorker.swift
//  githubtrends
//
//  Created by Raluca Toadere on 14/08/2020.
//  Copyright © 2020 selva. All rights reserved.
//

import Foundation

class RepoReadmeWorker {
    func retrieveRepoReadmeURL(author: String, name: String, completion: @escaping(Result<URL?, APIClient.Error>) -> Void) {
          APIClient().perform(request: RepoReadmeRequest(author: author, name: name)) { result in
              switch result {
              case .success(let response):
                  completion(.success(response.result))
              case .failure(let error):
                  completion(.failure(error))
              }
          }
      }

    func downloadRepoReadme(url: URL, completion: @escaping(Result<String?, APIClient.Error>) -> Void) {
        APIClient().perform(request: ReadmeDownloadRequest(url: url)) { result in
            switch result {
            case .success(let response):
                completion(.success(response.result))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

