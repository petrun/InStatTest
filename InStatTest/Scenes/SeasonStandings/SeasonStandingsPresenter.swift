//
//  SeasonStandingsPresenter.swift
//  InStatTest
//
//  Created by andy on 01.07.2022.
//

import UIKit

protocol SeasonStandingsView: AnyObject {
    func displayScreenTitle(title: String)
    func displayStandingsRetrievalError(title: String, message: String)
    func refreshStandingsView()
}

protocol SeasonStandingCellView {
    func display(title: String)
}

struct SeasonStandingTeamCellObject {
    let displayName: String
    let location: String
    let logoURL: String?
}

protocol SeasonStandingTeamCellView {
    func display(team: SeasonStandingTeamCellObject)
}

protocol SeasonStandingNoteCellView {
    func display(note: SeasonStandingNoteModel)
}

protocol SeasonStandingStatsCellView {
    func display(stats: [SeasonStandingStatsModel])
}

protocol SeasonStandingsPresenter {
    func viewDidLoad()
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    func numberOfSections() -> Int
    func numberOfRowsInSection(in section: Int) -> Int
    func titleForHeader(in section: Int) -> String?
}

final class SeasonStandingsPresenterImpl {
    private weak var view: SeasonStandingsView?
    private let displayStandingsUseCase: DisplayStandingsUseCase
    private let router: SeasonStandingsRouter
    private var standings: [SeasonStandingModel] = []
    private var season: LeagueSeasonModel

    init(
        view: SeasonStandingsView,
        season: LeagueSeasonModel,
        displayStandingsUseCase: DisplayStandingsUseCase,
        router: SeasonStandingsRouter
    ) {
        self.view = view
        self.season = season
        self.displayStandingsUseCase = displayStandingsUseCase
        self.router = router
    }
}

extension SeasonStandingsPresenterImpl: SeasonStandingsPresenter {
    func viewDidLoad() {
        view?.displayScreenTitle(title: season.displayName)
        displayStandingsUseCase.displayStandings { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let standings):
                self.standings = standings
                self.view?.refreshStandingsView()
            case .failure(let error):
                self.view?.displayStandingsRetrievalError(title: "Error", message: error.localizedDescription)
            }
        }
    }

    // TOOD: - Возможно лучше чтобы данные преобразовывались при получении
    private enum SeasonStandingType: Int {
        case team
        case stats
        case note
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let standing = standings[indexPath.section]

        switch SeasonStandingType(rawValue: indexPath.row) {
        case .team:
            let cell = tableView.dequeueReusableCell(withIdentifier: SeasonStandingTeamTableViewCell.id, for: indexPath) as! SeasonStandingTeamTableViewCell

            let team = standing.team

            let teamObject = SeasonStandingTeamCellObject(
                displayName: team.displayName,
                location: team.location,
                logoURL: team.logos.first?.href
            )

            cell.display(team: teamObject)
            return cell
        case .stats:
            let cell = tableView.dequeueReusableCell(withIdentifier: SeasonStandingStatsTableViewCell.id, for: indexPath) as! SeasonStandingStatsTableViewCell
            cell.display(stats: standing.stats)
            return cell
        case .note:
            let cell = tableView.dequeueReusableCell(withIdentifier: SeasonStandingNoteTableViewCell.id, for: indexPath) as! SeasonStandingNoteTableViewCell
            cell.display(note: standing.note!)
            return cell
        default:
            fatalError("Wrong standing type")
        }
    }

    func numberOfSections() -> Int {
        standings.count
    }

    func numberOfRowsInSection(in section: Int) -> Int {
        let standing = standings[section]
        return 2 + (standing.note != nil ? 1 : 0)
    }

    func titleForHeader(in section: Int) -> String? {
        "Section \(section)"
    }
}
