//
//  NavigationController.swift
//  githubtrends
//
//  Created by Raluca Toadere on 07/08/2020.
//  Copyright © 2020 selva. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBar.isTranslucent = false
        navigationBar.barTintColor = .white
        navigationBar.tintColor = .gray

        let attributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.blueBayoux]
        navigationBar.titleTextAttributes = attributes
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
}
