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
import Down
import WebKit

final class RepoDetailsViewController: UIViewController {

    var businessLogic: RepoDetailsBusinessLogic!
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
    @IBOutlet private weak var markupViewContainer: UIView!
    @IBOutlet private weak var markupViewContainerHeightConstraint: NSLayoutConstraint!

    private var markupView: DownView?

    private var repoDetails: RepoDetails?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupSubviews()

        setupRepoDetailsBinding()

        businessLogic.retrieveRepoDetails()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        avatarImageView.layoutIfNeeded()
        avatarImageView.layer.cornerRadius = avatarImageView.bounds.width / 2
    }

    private func setupSubviews() {
        avatarImageView.contentMode = .scaleAspectFill

        authorLabel.textColor = .pomegranate
        authorLabel.font = UIFont.preferredFont(forTextStyle: .title2, weight: .bold)
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
    }


    private func setupRepoDetailsBinding() {
        repoSubscription = businessLogic.repoDetailsBinding.sink { [weak self] repoDetails in
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

            if let readme = repoDetails.readme {
                self.readmeTitleLabel.isHidden = false
                self.show(readme: readme)
            } else {
                self.readmeTitleLabel.isHidden = true
                self.markupViewContainerHeightConstraint.constant = 0
            }
        }
    }

    private func show(readme: String) {
        if markupView == nil {
            buildMarkupView(readme: readme)
        } else {
            try? markupView?.update(markdownString: readme)
        }
    }

    private func buildMarkupView(readme: String) {
        let javaScript = """
        var meta = document.createElement('meta');
        meta.setAttribute('name', 'viewport');
        meta.setAttribute('content', 'width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no');
        document.getElementsByTagName('head')[0].appendChild(meta);
        """
        let userScript = WKUserScript(source: javaScript,
                                      injectionTime: WKUserScriptInjectionTime.atDocumentEnd,
                                      forMainFrameOnly: true)
        let wkUController = WKUserContentController()
        wkUController.addUserScript(userScript)
        let wkWebConfig = WKWebViewConfiguration()
        wkWebConfig.userContentController = wkUController

        guard let markupView = try? DownView(frame: .zero, markdownString: readme, configuration: wkWebConfig, didLoadSuccessfully: {
            self.markupView?.evaluateJavaScript("document.documentElement.scrollHeight", completionHandler: { (height, error) in
                self.markupViewContainerHeightConstraint?.constant = height as! CGFloat
            })
        }) else { return }

        markupViewContainer.backgroundColor = .clear
        markupView.isOpaque = false
        markupView.backgroundColor = .clear
        markupView.scrollView.backgroundColor = .clear
        markupViewContainer.addFillingSubview(markupView)
        self.markupView = markupView
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
