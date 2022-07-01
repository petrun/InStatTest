//
//  LeaguesListRouter.swift
//  InStatTest
//
//  Created by andy on 30.06.2022.
//

import Foundation

protocol LeaguesRouter {
    func presentDetailsView(for league: LeagueModel)
}

struct LeaguesRouterImpl: LeaguesRouter {
    private weak var performer: LeaguesViewController?

    init(performer: LeaguesViewController) {
        self.performer = performer
    }

    func presentDetailsView(for league: LeagueModel) {
        performer?.navigationController?.pushViewController(
            LeagueDetailsBuilderImpl(league: league).build(),
            animated: true
        )
    }
}
