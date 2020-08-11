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
        let currentPeriodStarCount: UInt
        let starsCount: UInt
        let forksCount: UInt
        let avatarURL: URL?

        enum RootCodingKeys: String, CodingKey {
            case author
            case name
            case description
            case currentPeriodStars
            case stars
            case forks
            case avatar
        }

        init(from decoder: Decoder) throws {
            let rootObject = try decoder.container(keyedBy: RootCodingKeys.self)
            author = try rootObject.decode(String.self, forKey: .author)
            name = try rootObject.decode(String.self, forKey: .name)
            descriptionText = try rootObject.decode(String.self, forKey: .description)
            currentPeriodStarCount = try rootObject.decode(UInt.self, forKey: .currentPeriodStars)
            starsCount = try rootObject.decode(UInt.self, forKey: .stars)
            forksCount = try rootObject.decode(UInt.self, forKey: .forks)

            if let avatarURLString = try? rootObject.decodeIfPresent(String.self, forKey: .avatar) {
                avatarURL = URL(string: avatarURLString)
            } else {
                avatarURL = nil
            }
        }
    }
}


