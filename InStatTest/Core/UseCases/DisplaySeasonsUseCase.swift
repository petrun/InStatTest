//
//  DisplaySeasonsUseCase.swift
//  InStatTest
//
//  Created by andy on 01.07.2022.
//

import Foundation

protocol DisplaySeasonsUseCase {
    func displaySeasons(for league: LeagueModel, completion: @escaping (Result<[LeagueSeasonModel]>) -> Void)
}

final class DisplaySeasonsUseCaseImpl {
    let leaguesGateway: LeaguesGateway

    init(leaguesGateway: LeaguesGateway) {
        self.leaguesGateway = leaguesGateway
    }
}

extension DisplaySeasonsUseCaseImpl: DisplaySeasonsUseCase {
    func displaySeasons(for league: LeagueModel, completion: @escaping (Result<[LeagueSeasonModel]>) -> Void) {
        leaguesGateway.fetchSeasons(for: league) { completion($0) }
    }
}
