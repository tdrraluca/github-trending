//
//  RepoDetailsViewModel.swift
//  githubtrends
//
//  Created by Raluca Toadere on 09/08/2020.
//  Copyright © 2020 selva. All rights reserved.
//

import Foundation
import Combine
import Down

protocol RepoDetailsBusinessLogic {
    var repoDetailsBinding: AnyPublisher<RepoDetails, Never> { get }

    init(preview: APIModel.RepoPreview)

    func retrieveRepoDetails()
}

final class RepoDetailsViewModel: RepoDetailsBusinessLogic {

    lazy var repoDetailsBinding: AnyPublisher<RepoDetails, Never> = {
        repoDetailsCurrentValueSubject.eraseToAnyPublisher()
    }()

    private var repoDetailsCurrentValueSubject: CurrentValueSubject<RepoDetails, Never>

    private let preview: APIModel.RepoPreview
    private var readme: String?

    init(preview: APIModel.RepoPreview) {
        self.preview = preview

        let repoDetails = RepoDetailsViewModel.detailsToPublish(preview: preview, readme: nil)
        repoDetailsCurrentValueSubject = CurrentValueSubject<RepoDetails, Never>((repoDetails))
    }

    func retrieveRepoDetails() {
        let worker = RepoReadmeWorker()
        worker.retrieveRepoReadmeURL(author: preview.author, name: preview.name) {  result in

            result.onSuccess { [weak self] url in
                guard let self = self else { return }
                guard let url = url else { return }

                worker.downloadRepoReadme(url: url) { result in
                    result.onSuccess { readme in
                        let repoDetails = RepoDetailsViewModel.detailsToPublish(preview: self.preview,
                                                                                readme: readme)
                        self.repoDetailsCurrentValueSubject.send(repoDetails)
                    }
                }
            }
        }
    }

    private static func detailsToPublish(preview: APIModel.RepoPreview, readme: String?)-> RepoDetails {
        let starsCount = Strings.starsCount.localized(with: "\(preview.starsCount)")
        let forksCount = Strings.forksCount.localized(with: "\(preview.forksCount)")

        let repoDetails = RepoDetails(name: preview.name,
                                      author: preview.author,
                                      description: preview.descriptionText,
                                      starsCount: starsCount,
                                      forksCount: forksCount,
                                      avatarURL: preview.avatarURL,
                                      readme: readme)

        return repoDetails
    }
}

