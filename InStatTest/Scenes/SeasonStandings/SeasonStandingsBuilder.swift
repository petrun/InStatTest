//
//  SeasonStandingsBuilder.swift
//  InStatTest
//
//  Created by andy on 01.07.2022.
//

import Foundation

protocol SeasonStandingsBuilder {
    func build() -> SeasonStandingsViewController
}

final class SeasonStandingsBuilderImpl {
    let league: LeagueModel
    let season: LeagueSeasonModel

    init(league: LeagueModel, season: LeagueSeasonModel) {
        self.league = league
        self.season = season
    }
}

extension SeasonStandingsBuilderImpl: SeasonStandingsBuilder {
    func build() -> SeasonStandingsViewController {
        let vc = SeasonStandingsViewController()
        vc.presenter = SeasonStandingsPresenterImpl(
            view: vc,
            season: season,
            displayStandingsUseCase: DisplayStandingsUseCaseImpl(
                league: league,
                season: season,
                leaguesGateway: ApiLeaguesGatewayImpl(
                    apiClient: ApiClientImplementation(
                        urlSessionConfiguration: URLSessionConfiguration.default,
                        delegateQueue: OperationQueue.main
                    )
                )
            ),
            router: SeasonStandingsRouterImpl(performer: vc)
        )

        return vc
    }
}
