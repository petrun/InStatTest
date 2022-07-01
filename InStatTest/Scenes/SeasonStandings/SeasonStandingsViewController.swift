//
//  SeasonStandingsViewController.swift
//  InStatTest
//
//  Created by andy on 01.07.2022.
//

import UIKit

final class SeasonStandingsViewController: UIViewController {

    var presenter: SeasonStandingsPresenter!

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
        tableView.register(SeasonStandingTeamTableViewCell.self, forCellReuseIdentifier: SeasonStandingTeamTableViewCell.id)
        tableView.register(SeasonStandingNoteTableViewCell.self, forCellReuseIdentifier: SeasonStandingNoteTableViewCell.id)
        tableView.register(SeasonStandingStatsTableViewCell.self, forCellReuseIdentifier: SeasonStandingStatsTableViewCell.id)
    }
}

extension SeasonStandingsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        presenter.numberOfSections()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.numberOfRowsInSection(in: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        presenter.tableView(tableView, cellForRowAt: indexPath)
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        presenter.titleForHeader(in: section)
    }
}

extension SeasonStandingsViewController: SeasonStandingsView {
    func displayScreenTitle(title: String) {
        self.title = title
    }

    func displayStandingsRetrievalError(title: String, message: String) {
        presentAlert(withTitle: title, message: message)
    }

    func refreshStandingsView() {
        tableView.reloadData()
    }
}
