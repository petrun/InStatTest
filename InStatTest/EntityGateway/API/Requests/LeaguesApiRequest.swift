//
//  LeaguesApiRequest.swift
//  InStatTest
//
//  Created by andy on 30.06.2022.
//

import Foundation

struct LeaguesApiRequest: ApiRequest {
    var urlRequest: URLRequest {
        let url: URL! = URL(string: "https://api-football-standings.azharimm.site/leagues")
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        return request
    }
}
