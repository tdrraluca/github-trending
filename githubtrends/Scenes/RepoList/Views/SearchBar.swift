//
//  SearchBar.swift
//  githubtrends
//
//  Created by Raluca Toadere on 09/08/2020.
//  Copyright © 2020 selva. All rights reserved.
//

import UIKit

protocol SearchBarDelegate: class {
    func searchBar(_ bar: SearchBar, didChange text: String)
}

class SearchBar: UIView {
    @IBOutlet private var contentView: UIView!
    
    @IBOutlet private weak var placeholderLabel: UILabel!
    @IBOutlet private weak var textField: UITextField!
    @IBOutlet private weak var iconImageView: UIImageView!
    @IBOutlet private weak var placeholderStackView: UIStackView!
    
    weak var delegate: SearchBarDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupSubviews()
    }

    private func setupSubviews() {
        Bundle.main.loadNibNamed("SearchBar",
                                 owner: self,
                                 options: nil)

        addFillingSubview(contentView)
        contentView.backgroundColor = UIColor.frenchGray

        placeholderStackView.isUserInteractionEnabled = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapPlaceholder(_:)))
        placeholderStackView.addGestureRecognizer(tapGestureRecognizer)

        textField.backgroundColor = .white
        textField.delegate = self
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)

        placeholderLabel.text = Strings.searchPlaceholder.localized
        placeholderLabel.textColor = .boulderGray
        placeholderLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)

        iconImageView.tintColor = .boulderGray
    }

    // MARK: - Target Action

    @objc func textFieldDidChange(_ sender: UITextField) {
        let queryText = sender.text ?? ""
        delegate?.searchBar(self, didChange: queryText)
    }

    @objc private func didTapPlaceholder(_ sender: UITapGestureRecognizer) {
        textField.becomeFirstResponder()
    }
}

extension SearchBar: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        placeholderStackView.isHidden = true
    }

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        placeholderStackView.isHidden = textField.text?.isEmpty == false
        return true
    }
}
