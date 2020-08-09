//
//  Strings.swift
//  githubtrends
//
//  Created by Raluca Toadere on 09/08/2020.
//  Copyright © 2020 selva. All rights reserved.
//

import Foundation

enum Strings {
    case errorTitle
    case ok
    case repoListTitle
    case repoListErrorMessage
    case searchPlaceholder

    var localized: String {
        return NSLocalizedString(localizationKey, tableName: nil, comment: "")
    }

    private var localizationKey: String {
        switch self {
        case .errorTitle:
            return "ERROR_TITLE"
        case .ok:
            return "OK"
        case .repoListTitle:
            return "REPO_LIST_TITLE"
        case .repoListErrorMessage:
            return "REPO_LIST_ERROR_MESSAGE"
        case .searchPlaceholder:
            return "SEARCH_PLACEHOLDER"
        }
    }
}
