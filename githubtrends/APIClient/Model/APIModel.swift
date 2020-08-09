//
//  APIRepoPreview.swift
//  githubtrends
//
//  Created by Raluca Toadere on 07/08/2020.
//  Copyright © 2020 selva. All rights reserved.
//

import Foundation

enum APIModel {
    struct RepoPreview: Decodable {
        let author: String
        let name: String
        let descriptionText: String
        let currentPerioStarCount: UInt

        enum RootCodingKeys: String, CodingKey {
            case author
            case name
            case description
            case currentPeriodStars
        }

        init(from decoder: Decoder) throws {
            let rootObject = try decoder.container(keyedBy: RootCodingKeys.self)
            author = try rootObject.decode(String.self, forKey: .author)
            name = try rootObject.decode(String.self, forKey: .name)
            descriptionText = try rootObject.decode(String.self, forKey: .description)
            currentPerioStarCount = try rootObject.decode(UInt.self, forKey: .currentPeriodStars)
        }
    }
}


