//
//  DisplayStandingsUseCase.swift
//  InStatTest
//
//  Created by andy on 01.07.2022.
//

import Foundation

protocol DisplayStandingsUseCase {
    func displayStandings(completion: @escaping (Result<[SeasonStandingModel]>) -> Void)
}

final class DisplayStandingsUseCaseImpl {
    let league: LeagueModel
    let season: LeagueSeasonModel
    let leaguesGateway: LeaguesGateway

    init(league: LeagueModel, season: LeagueSeasonModel, leaguesGateway: LeaguesGateway) {
        self.league = league
        self.season = season
        self.leaguesGateway = leaguesGateway
    }
}

extension DisplayStandingsUseCaseImpl: DisplayStandingsUseCase {
    func displayStandings(completion: @escaping (Result<[SeasonStandingModel]>) -> Void) {
        leaguesGateway.fetchStandings(for: league, and: season) { completion($0) }
    }
}
