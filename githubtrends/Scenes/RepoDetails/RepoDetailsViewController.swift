//
//  RepoDetailsViewController.swift
//  githubtrends
//
//  Created by Raluca Toadere on 09/08/2020.
//  Copyright © 2020 selva. All rights reserved.
//

import UIKit
import Combine

final class RepoDetailsViewController: UIViewController {

    var business: RepoDetailsBusiness!
    var repoSubscription: AnyCancellable?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupBindings()
    }

    private func setupBindings() {
        repoSubscription = business.repoDetailsBinding.sink { [weak self] repoPreview in
            guard let self = self else { return }

            self.navigationItem.title = repoPreview.name
        }
    }
}
