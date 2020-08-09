//
//  RepoListViewModel.swift
//  githubtrends
//
//  Created by Raluca Toadere on 07/08/2020.
//  Copyright © 2020 selva. All rights reserved.
//

import Foundation
import Combine

struct RepoListError: Error {
    var localizedDescription: String {
        return Strings.repoListErrorMessage.localized
    }
}

typealias RepoListResult = Result<[RepoPreview], RepoListError>

protocol RepoListBusiness {
    var reposBinding: AnyPublisher<RepoListResult, Never> { get }

    func retrieveRepos()

    func filteredRepos(query: String)
    func selectRepo(at index: Int)
}

protocol RepoListOutput {
    var preview: APIModel.RepoPreview? { get }
}

final class RepoListViewModel: RepoListBusiness {

    private var repos = [RepoPreview]()
    private var apiRepos = [APIModel.RepoPreview]()
    private var selectedRepoIndex: Int?

    lazy var reposBinding: AnyPublisher<RepoListResult, Never> = {
        reposCurrentValueSubject.eraseToAnyPublisher()
    }()

    private var reposCurrentValueSubject = CurrentValueSubject<RepoListResult, Never>(.success([]))

    func retrieveRepos() {
        RepoListWorker().retrieveAPITrendingRepos { [weak self] result in
            guard let self = self else { return }

            result.onSuccess { apiRepos in
                self.apiRepos = apiRepos

                let repos: [RepoPreview] = apiRepos.map {
                    let starCount = "\u{2606} \($0.currentPerioStarCount) stars this week"
                    return RepoPreview(name: $0.name,
                                       descriptionText: $0.descriptionText,
                                       starCount: starCount)
                }
                self.repos = repos
                self.reposCurrentValueSubject.send(.success(repos))
            }.onFailure { _ in
                self.reposCurrentValueSubject.send(.failure(RepoListError()))
            }
        }
    }

    func filteredRepos(query: String) {
        guard !query.isEmpty else {
            self.reposCurrentValueSubject.send(.success(repos))
            return
        }

        let filtered = repos.filter { repo in
            return repo.name.contains(query) || repo.descriptionText.contains(query)
        }

        self.reposCurrentValueSubject.send(.success(filtered))
    }

    func selectRepo(at index: Int) {
        selectedRepoIndex = index
    }
}

extension RepoListViewModel: RepoListOutput {
    var preview: APIModel.RepoPreview? {
        guard let index = selectedRepoIndex else { return nil }
        
        return apiRepos[index]
    }
}
