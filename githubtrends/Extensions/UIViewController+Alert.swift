//
//  UIViewController+Alert.swift
//  githubtrends
//
//  Created by Raluca Toadere on 09/08/2020.
//  Copyright © 2020 selva. All rights reserved.
//

import UIKit

extension UIViewController {
    func showAlert(title: String?,
                   message: String?,
                   cancelButtonTitle: String?,
                   cancelHandler: (() -> Void)?) {

        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: cancelButtonTitle,
                                         style: .cancel,
                                         handler: { _ in
            cancelHandler?()
        })
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
}
