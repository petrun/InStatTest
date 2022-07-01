//
//  LeaguesGateway.swift
//  InStatTest
//
//  Created by andy on 30.06.2022.
//

import Foundation

protocol LeaguesGateway {
    func fetchLeagues(completion: @escaping (Result<[LeagueModel]>) -> Void)
    func fetchSeasons(for league: LeagueModel, completion: @escaping (Result<[LeagueSeasonModel]>) -> Void)
    func fetchStandings(for league: LeagueModel, and season: LeagueSeasonModel, completion: @escaping (Result<[SeasonStandingModel]>) -> Void)
}
