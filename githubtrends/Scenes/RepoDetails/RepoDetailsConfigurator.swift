//
//  RepoDetailsConfigurator.swift
//  githubtrends
//
//  Created by Raluca Toadere on 09/08/2020.
//  Copyright © 2020 selva. All rights reserved.
//

import UIKit

class RepoDetailsConfigurator {
    class func configureScene(preview: APIModel.RepoPreview) -> UIViewController {
        let viewController = RepoDetailsViewController()
        let viewModel = RepoDetailsViewModel(preview: preview)
        viewController.businessLogic = viewModel
        return viewController
    }
}
