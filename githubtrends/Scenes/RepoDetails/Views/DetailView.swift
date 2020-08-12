//
//  DetailView.swift
//  githubtrends
//
//  Created by Raluca Toadere on 11/08/2020.
//  Copyright © 2020 selva. All rights reserved.
//

import UIKit

struct DetailViewModel {
    let icon: UIImage
    let detail: String
}

class DetailView: UIView {
    @IBOutlet private var contentView: UIView!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupSubviews()
    }

    private func setupSubviews() {
        Bundle.main.loadNibNamed("DetailView",
                                 owner: self,
                                 options: nil)
        addFillingSubview(contentView)

        imageView.tintColor = .blueBayoux
        label.textColor = .blueBayoux
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
    }

    func set(_ model: DetailViewModel) {
        imageView.image = model.icon
        label.text = model.detail
    }
    
}
