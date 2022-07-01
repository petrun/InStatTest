//
//  LeaguesListViewController.swift
//  InStatTest
//
//  Created by andy on 30.06.2022.
//

import UIKit

class LeaguesViewController: UIViewController {

    var presenter: LeaguesPresenter!

    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        title = "Leagues"

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
        tableView.register(LeagueTableViewCell.self, forCellReuseIdentifier: LeagueTableViewCell.id)
    }
}

extension LeaguesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.numberOfLeagues
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LeagueTableViewCell.id, for: indexPath) as! LeagueTableViewCell
        presenter.configure(cell: cell, at: indexPath)

        return cell
    }
}

extension LeaguesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelect(row: indexPath.row)
    }
}

extension LeaguesViewController: LeaguesView {
    func refreshLeague(at indexPath: IndexPath) {
        tableView.reloadRows(at: [indexPath], with: .none)
    }

    func refreshLeaguesView() {
        tableView.reloadData()
    }

    func displayLeaguesRetrievalError(title: String, message: String) {
        presentAlert(withTitle: title, message: message)
    }
}
