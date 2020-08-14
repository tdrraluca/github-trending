//
//  RepoPreviewCell.swift
//  githubtrends
//
//  Created by Raluca Toadere on 07/08/2020.
//  Copyright © 2020 selva. All rights reserved.
//

import UIKit

class RepoPreviewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var starsCountLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        nameLabel.textColor = .black
        nameLabel.font = UIFont.preferredFont(forTextStyle: .headline, weight: .bold)
        nameLabel.adjustsFontForContentSizeCategory = true

        starsCountLabel.textColor = .black
        starsCountLabel.font = UIFont.preferredFont(forTextStyle: .body)
        starsCountLabel.adjustsFontForContentSizeCategory = true

        descriptionLabel.textColor = .boulderGray
        descriptionLabel.font = UIFont.preferredFont(forTextStyle: .body)
        descriptionLabel.adjustsFontForContentSizeCategory = true

        descriptionLabel.numberOfLines = 0

        selectionStyle = .none
    }

    func set(repo: RepoPreview) {
        nameLabel.text = repo.name
        starsCountLabel.text = repo.starCount
        descriptionLabel.text = repo.descriptionText
    }
}
