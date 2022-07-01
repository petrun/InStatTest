//
//  LeaguesDetailsPresenter.swift
//  InStatTest
//
//  Created by andy on 01.07.2022.
//

import UIKit

protocol LeagueDetailsView: AnyObject {
    func displayScreenTitle(title: String)
    func displaySeasonsRetrievalError(title: String, message: String)
    func refreshSeasonsView()
}

protocol LeagueSeasonCellView {
    func display(title: String)
}

protocol LeagueDetailsPresenter {
    var numberOfSeasons: Int { get }
    func viewDidLoad()
    func configure(cell: LeagueSeasonCellView, forRow row: Int)
    func didSelect(row: Int)
}

final class LeagueDetailsPresenterImpl {
    private weak var view: LeagueDetailsView?
    private let displaySeasonsUseCase: DisplaySeasonsUseCase
    private let router: LeagueDetailsRouter
    private let league: LeagueModel
    private var seasons: [LeagueSeasonModel] = []

    init(
        view: LeagueDetailsView,
        league: LeagueModel,
        displaySeasonsUseCase: DisplaySeasonsUseCase,
        router: LeagueDetailsRouter
    ) {
        self.view = view
        self.league = league
        self.displaySeasonsUseCase = displaySeasonsUseCase
        self.router = router
    }
}

extension LeagueDetailsPresenterImpl: LeagueDetailsPresenter {
    var numberOfSeasons: Int { seasons.count }

    func viewDidLoad() {
        view?.displayScreenTitle(title: league.name)
        displaySeasonsUseCase.displaySeasons(for: league) { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let seasons):
                self.seasons = seasons
                self.view?.refreshSeasonsView()
            case .failure(let error):
                self.view?.displaySeasonsRetrievalError(title: "Error", message: error.localizedDescription)
            }
        }
    }

    func configure(cell: LeagueSeasonCellView, forRow row: Int) {
        let season = seasons[row]

        cell.display(title: season.displayName)
    }

    func didSelect(row: Int) {
        router.presentSeasonsView(for: league, and: seasons[row])
    }
}
