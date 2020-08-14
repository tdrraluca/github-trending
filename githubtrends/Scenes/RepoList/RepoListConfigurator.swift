//
//  RepoListConfigurator.swift
//  githubtrends
//
//  Created by Raluca Toadere on 07/08/2020.
//  Copyright © 2020 selva. All rights reserved.
//

import UIKit

final class RepoListConfigurator {
    class func configureScene() -> UIViewController {
        let viewController = RepoListViewController()
        let viewModel = RepoListViewModel()
        viewController.businessLogic = viewModel
        viewController.router = RepoListRouter(viewController: viewController, output: viewModel)
        return NavigationController(rootViewController: viewController)
    }
}
