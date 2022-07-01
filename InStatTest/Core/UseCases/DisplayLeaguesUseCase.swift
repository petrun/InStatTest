//
//  DisplayLeaguesUseCase.swift
//  InStatTest
//
//  Created by andy on 30.06.2022.
//

import Foundation

protocol DisplayLeaguesUseCase {
    func displayLeagues(completion: @escaping (Result<[LeagueModel]>) -> Void)
}

final class DisplayLeaguesUseCaseImpl {
    let leaguesGateway: LeaguesGateway

    init(leaguesGateway: LeaguesGateway) {
        self.leaguesGateway = leaguesGateway
    }
}

extension DisplayLeaguesUseCaseImpl: DisplayLeaguesUseCase {
    func displayLeagues(completion: @escaping (Result<[LeagueModel]>) -> Void) {
        leaguesGateway.fetchLeagues { completion($0) }
    }
}
