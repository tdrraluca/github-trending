//
//  RepoDetailsViewModel.swift
//  githubtrends
//
//  Created by Raluca Toadere on 09/08/2020.
//  Copyright © 2020 selva. All rights reserved.
//

import Foundation
import Combine


struct RepoDetailsError: Error {
    var localizedDescription: String {
        return Strings.repoListErrorMessage.localized
    }
}

protocol RepoDetailsBusiness {
    init(preview: APIModel.RepoPreview)

    func retrieveRepoDetails()

    var repoDetailsBinding: AnyPublisher<RepoDetails, Never> { get }
}

final class RepoDetailsViewModel: RepoDetailsBusiness {

    lazy var repoDetailsBinding: AnyPublisher<RepoDetails, Never> = {
        repoDetailsCurrentValueSubject.eraseToAnyPublisher()
    }()

    private var repoDetailsCurrentValueSubject: CurrentValueSubject<RepoDetails, Never>

    init(preview: APIModel.RepoPreview) {
        let repoDetails = RepoDetails(name: preview.name,
                                      author: preview.author,
                                      description: preview.descriptionText)

        repoDetailsCurrentValueSubject = CurrentValueSubject<RepoDetails, Never>(repoDetails)
    }

    func retrieveRepoDetails() {

    }
}
