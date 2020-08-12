//
//  RepoDetailsViewController.swift
//  githubtrends
//
//  Created by Raluca Toadere on 09/08/2020.
//  Copyright © 2020 selva. All rights reserved.
//

import UIKit
import Combine
import Kingfisher

final class RepoDetailsViewController: UIViewController {

    var business: RepoDetailsBusiness!
    var repoSubscription: AnyCancellable?

    @IBOutlet private weak var detailsSeparatorView: UIView!
    @IBOutlet private weak var forksDetailView: DetailView!
    @IBOutlet private weak var starsDetailsView: DetailView!
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var topSectionView: UIView!
    @IBOutlet private weak var detailsSegmentedView: UIView!
    @IBOutlet private weak var bottomSectionView: UIView!

    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var authorLabel: UILabel!
    @IBOutlet private weak var separatorView: UIView!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var readmeTitleLabel: UILabel!
    @IBOutlet private weak var readmeTextView: UITextView!

    private var repoDetails: RepoDetails?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupBindings()

        setupSubviews()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        avatarImageView.layoutIfNeeded()
        avatarImageView.layer.cornerRadius = avatarImageView.bounds.width / 2
    }

    private func setupBindings() {
        repoSubscription = business.repoDetailsBinding.sink { [weak self] repoDetails in
            guard let self = self else { return }

            self.navigationItem.title = repoDetails.name

            if let avatarURL = repoDetails.avatarURL {
                self.avatarImageView.kf.setImage(with: avatarURL)
            } else {
                self.avatarImageView.isHidden = true
            }
            self.authorLabel.text = repoDetails.author
            self.descriptionLabel.text = repoDetails.description

            self.starsDetailsView.set(DetailViewModel(icon: self.starImage(),
                                                      detail: repoDetails.starsCount))
            self.forksDetailView.set(DetailViewModel(icon: self.forkImage(),
                                                     detail: repoDetails.forksCount))
        }
    }

    private func setupSubviews() {
        avatarImageView.contentMode = .scaleAspectFill

        authorLabel.textColor = .pomegranate
        authorLabel.font = UIFont.preferredFont(forTextStyle: .title2)
        authorLabel.textAlignment = .center

        separatorView.backgroundColor = .alto

        descriptionLabel.textColor = .gullGray
        descriptionLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = 0

        detailsSegmentedView?.superview?.bringSubviewToFront(detailsSegmentedView)
        detailsSegmentedView.backgroundColor = .white
        detailsSegmentedView.layer.borderWidth = 1.0
        detailsSegmentedView.layer.borderColor = UIColor.frenchGray.cgColor
        detailsSegmentedView.layer.cornerRadius = 6.0
        detailsSegmentedView.clipsToBounds = true
        detailsSeparatorView.backgroundColor = .frenchGray

        bottomSectionView.backgroundColor = .wildSand
        scrollView.backgroundColor = .wildSand

        readmeTitleLabel.text = "Readme.md"
        readmeTitleLabel.textColor = .papaGreen
        readmeTitleLabel.font = UIFont.preferredFont(forTextStyle: .title2)

        readmeTextView.backgroundColor = .clear
    }

    private func starImage() -> UIImage {
        let imageConfiguration = UIImage.SymbolConfiguration(scale: .small)
        return UIImage(systemName: "star.fill", withConfiguration: imageConfiguration)!
    }

    private func forkImage() -> UIImage {
        let imageConfiguration = UIImage.SymbolConfiguration(scale: .small)
        return UIImage(systemName: "tuningfork", withConfiguration: imageConfiguration)!
    }
}
