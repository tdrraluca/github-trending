//
//  RepoListViewController.swift
//  githubtrends
//
//  Created by Raluca Toadere on 07/08/2020.
//  Copyright © 2020 selva. All rights reserved.
//

import UIKit
import Combine

class RepoListViewController: UIViewController {

    var business: RepoListBusiness!
    var reposSubscription: AnyCancellable?

    private var repos = [RepoPreview]()

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var searchBar: SearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = Strings.repoListTitle.localized

        view.backgroundColor = .white
        setupTableView()
        setupReposBinding()

        searchBar.delegate = self
    }

    private func setupTableView() {
        let nib = UINib(nibName: "RepoPreviewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "RepoPreviewCell")
        tableView.delegate = self
        tableView.dataSource = self
    }

    private func setupReposBinding() {
        reposSubscription = business.reposBinding.sink { [weak self] result in
            guard let self = self else { return }

            result.onSuccess { repos in
                self.repos = repos
                self.displayRepos()
            }.onFailure { error in
                self.showAlert(title: Strings.errorTitle.localized,
                          message: error.localizedDescription,
                          cancelButtonTitle: Strings.ok.localized,
                          cancelHandler: nil)
            }
        }

        business.retrieveRepos()
    }

    private func displayRepos() {
        tableView.reloadData()
    }
}

extension RepoListViewController: SearchBarDelegate {
    func searchBar(_ bar: SearchBar, didChange text: String) {
        business.filteredRepos(query: text)
    }
}

extension RepoListViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repos.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RepoPreviewCell") as? RepoPreviewCell else {
            fatalError("Could not dequeue cell with identifier RepoPreviewCell")
        }

        cell.set(repo: repos[indexPath.row])
        return cell
    }
}

extension RepoListViewController: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchBar.endEditing(true)
    }
}

