//
//  SeasonStandingsResponse.swift
//  InStatTest
//
//  Created by andy on 01.07.2022.
//

import Foundation

struct SeasonStandingsResponse: Decodable {
    let status: Bool
    let data: SeasonStandingsResponseData
}

struct SeasonStandingsResponseData: Decodable {
    let standings: [SeasonStandingModel]
}
