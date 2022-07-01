//
//  LeagueSeasonModel.swift
//  InStatTest
//
//  Created by andy on 30.06.2022.
//

import Foundation

struct LeagueSeasonModel: Decodable {
    let year: Int
    let displayName: String
    let types: [SeasonTypeModel]
}

struct SeasonTypeModel: Decodable {
    let id: String
    let name: String
    let abbreviation: String
    let hasStandings: Bool
}
