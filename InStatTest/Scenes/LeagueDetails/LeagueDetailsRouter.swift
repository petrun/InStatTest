//
//  LeagueDetailsRouter.swift
//  InStatTest
//
//  Created by andy on 01.07.2022.
//

import Foundation

protocol LeagueDetailsRouter {
    func dismissView()
    func presentSeasonsView(for league: LeagueModel, and season: LeagueSeasonModel)
}

struct LeagueDetailsRouterImpl {
    private weak var performer: LeagueDetailsViewController?

    init(performer: LeagueDetailsViewController) {
        self.performer = performer
    }
}

extension LeagueDetailsRouterImpl: LeagueDetailsRouter {
    func dismissView() {
        let _ = performer?.navigationController?.popViewController(animated: true)
    }

    func presentSeasonsView(for league: LeagueModel, and season: LeagueSeasonModel) {
        performer?.navigationController?.pushViewController(
            SeasonStandingsBuilderImpl(league: league, season: season).build(),
            animated: true
        )
    }
}
