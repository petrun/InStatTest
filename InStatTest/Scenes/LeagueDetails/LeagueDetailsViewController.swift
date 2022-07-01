//
//  LeaguesDetailsViewController.swift
//  InStatTest
//
//  Created by andy on 01.07.2022.
//

import UIKit

final class LeagueDetailsViewController: UIViewController {

    var presenter: LeagueDetailsPresenter!

    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        configureTableView()

        presenter.viewDidLoad()
    }

    private func configureTableView() {
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])

        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(LeagueSeasonTableViewCell.self, forCellReuseIdentifier: LeagueSeasonTableViewCell.id)
    }
}

extension LeagueDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.numberOfSeasons
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LeagueSeasonTableViewCell.id, for: indexPath) as! LeagueSeasonTableViewCell
        presenter.configure(cell: cell, forRow: indexPath.row)

        return cell
    }
}

extension LeagueDetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelect(row: indexPath.row)
    }
}

extension LeagueDetailsViewController: LeagueDetailsView {
    func displayScreenTitle(title: String) {
        self.title = title
    }

    func displaySeasonsRetrievalError(title: String, message: String) {
        presentAlert(withTitle: title, message: message)
    }

    func refreshSeasonsView() {
        tableView.reloadData()
    }
}
