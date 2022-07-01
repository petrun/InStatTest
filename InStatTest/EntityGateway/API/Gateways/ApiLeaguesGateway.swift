//
//  ApiLeaguesGateway.swift
//  InStatTest
//
//  Created by andy on 30.06.2022.
//

import Foundation

protocol ApiLeaguesGateway: LeaguesGateway {
}

final class ApiLeaguesGatewayImpl {
    let apiClient: ApiClient

    init(apiClient: ApiClient) {
        self.apiClient = apiClient
    }
}

extension ApiLeaguesGatewayImpl: ApiLeaguesGateway {
    func fetchLeagues(completion: @escaping (Result<[LeagueModel]>) -> Void) {
        apiClient.execute(request: LeaguesApiRequest()) { (result: Result<ApiResponse<LeagueResponse>>) in
            switch result {
            case .success(let response):
                completion(.success(response.entity.data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func fetchSeasons(for league: LeagueModel, completion: @escaping (Result<[LeagueSeasonModel]>) -> Void) {
        apiClient.execute(request: LeagueSeasonsApiRequest(leagueId: league.id)) { (result: Result<ApiResponse<LeagueSeasonsResponse>>) in
            switch result {
            case .success(let response):
                completion(.success(response.entity.data.seasons))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func fetchStandings(for league: LeagueModel, and season: LeagueSeasonModel, completion: @escaping (Result<[SeasonStandingModel]>) -> Void) {
        apiClient.execute(request: SeasonStandingApiRequest(leagueId: league.id, year: season.year)) { (result: Result<ApiResponse<SeasonStandingsResponse>>) in
            switch result {
            case .success(let response):
                completion(.success(response.entity.data.standings))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
