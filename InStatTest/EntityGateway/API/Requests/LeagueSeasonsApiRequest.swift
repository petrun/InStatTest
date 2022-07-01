//
//  LeagueSeasonsApiRequest.swift
//  InStatTest
//
//  Created by andy on 01.07.2022.
//

import Foundation

struct LeagueSeasonsApiRequest: ApiRequest {
    let leagueId: String

    var urlRequest: URLRequest {
        let url: URL! = URL(string: "https://api-football-standings.azharimm.site/leagues/\(leagueId)/seasons")
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        return request
    }
}
