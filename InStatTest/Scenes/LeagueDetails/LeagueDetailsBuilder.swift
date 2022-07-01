//
//  LeagueDetailsBuilder.swift
//  InStatTest
//
//  Created by andy on 01.07.2022.
//

import Foundation

protocol LeagueDetailsBuilder {
    func build() -> LeagueDetailsViewController
}

final class LeagueDetailsBuilderImpl: LeagueDetailsBuilder {
    let league: LeagueModel

    init(league: LeagueModel) {
        self.league = league
    }

    func build() -> LeagueDetailsViewController {
        let vc = LeagueDetailsViewController()
        vc.presenter = LeagueDetailsPresenterImpl(
            view: vc,
            league: league,
            displaySeasonsUseCase: DisplaySeasonsUseCaseImpl(
                leaguesGateway: ApiLeaguesGatewayImpl(
                    apiClient: ApiClientImplementation(
                        urlSessionConfiguration: URLSessionConfiguration.default,
                        delegateQueue: OperationQueue.main
                    )
                )
            ),
            router: LeagueDetailsRouterImpl(performer: vc)
        )

        return vc
    }
}
