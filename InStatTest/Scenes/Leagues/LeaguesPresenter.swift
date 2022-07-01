//
//  LeaguesListPresenter.swift
//  InStatTest
//
//  Created by andy on 30.06.2022.
//

import UIKit

protocol LeaguesView: AnyObject {
    func refreshLeaguesView()
    func refreshLeague(at indexPath: IndexPath)
    func displayLeaguesRetrievalError(title: String, message: String)
}

protocol LeaguesCellView {
    func display(title: String)
    func display(abbr: String)
    func display(logoURL: String)
}

protocol LeaguesPresenter {
    var numberOfLeagues: Int { get }
    func viewDidLoad()
    func configure(cell: LeaguesCellView, at indexPath: IndexPath)
    func didSelect(row: Int)
}

final class LeaguesPresenterImpl: LeaguesPresenter {

    var numberOfLeagues: Int { leagues.count }

    private weak var view: LeaguesView?
    private let displayLeaguesUseCase: DisplayLeaguesUseCase
    private let router: LeaguesRouter

    private var leagues: [LeagueModel] = []

    init(
        view: LeaguesView,
        displayLeaguesUseCase: DisplayLeaguesUseCase,
        router: LeaguesRouter
    ) {
        self.view = view
        self.displayLeaguesUseCase = displayLeaguesUseCase
        self.router = router
    }

    func viewDidLoad() {
        displayLeaguesUseCase.displayLeagues { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let leagues):
                self.leagues = leagues
                self.view?.refreshLeaguesView()
            case .failure(let error):
                self.view?.displayLeaguesRetrievalError(title: "Error", message: error.localizedDescription)
            }
        }
    }

    var imageLoader = ImageLoader()

    func configure(cell: LeaguesCellView, at indexPath: IndexPath) {
        let league = leagues[indexPath.row]

        cell.display(title: league.name)
        cell.display(abbr: league.abbr)
        cell.display(logoURL: league.logos.light)
    }

    func didSelect(row: Int) {
        router.presentDetailsView(for: leagues[row])
    }
}
