//
//  SeasonsResponse.swift
//  InStatTest
//
//  Created by andy on 30.06.2022.
//

import Foundation

struct LeagueSeasonsResponse: Decodable {
    let status: Bool
    let data: LeagueSeasonsResponseData
}

struct LeagueSeasonsResponseData: Decodable {
    let seasons: [LeagueSeasonModel]
}
