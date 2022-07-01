//
//  LeagueSeasonStandingApiRequest.swift
//  InStatTest
//
//  Created by andy on 01.07.2022.
//

import Foundation

struct SeasonStandingApiRequest: ApiRequest {
    let leagueId: String
    let year: Int

    var urlRequest: URLRequest {
        let url: URL! = URL(string: "https://api-football-standings.azharimm.site/leagues/\(leagueId)/standings?season=\(year)&sort=asc")
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        return request
    }
}
