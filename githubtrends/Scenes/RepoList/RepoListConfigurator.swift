//
//  RepoListConfigurator.swift
//  githubtrends
//
//  Created by Raluca Toadere on 07/08/2020.
//  Copyright © 2020 selva. All rights reserved.
//

import UIKit

class RepoListConfigurator {
    class func configureScene() -> UIViewController {
        let viewController = RepoListViewController()
        let navigationController = NavigationController(rootViewController: viewController)
        let viewModel = RepoListViewModel()
        viewController.business = viewModel
        return navigationController
    }
}
