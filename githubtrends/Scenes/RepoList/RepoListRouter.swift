//
//  RepoListRouter.swift
//  githubtrends
//
//  Created by Raluca Toadere on 09/08/2020.
//  Copyright © 2020 selva. All rights reserved.
//

import UIKit

protocol RepoListDataPassing {
    init(viewController: UIViewController, output: RepoListOutput)
}

protocol RepoListRouting {
    func routeToDetails()
}

final class RepoListRouter: RepoListDataPassing, RepoListRouting {
    private var output: RepoListOutput
    private weak var viewController: UIViewController!

    init(viewController: UIViewController, output: RepoListOutput) {
        self.viewController = viewController
        self.output = output
    }

    func routeToDetails() {
        guard let preview = output.preview else {
            return
        }

        let detailsViewController = RepoDetailsConfigurator.configureScene(preview: preview)
        viewController.navigationController?.pushViewController(detailsViewController, animated: true)
    }
}
