//
//  LeagueSeasonStanding.swift
//  InStatTest
//
//  Created by andy on 01.07.2022.
//

import Foundation

struct SeasonStandingModel: Decodable {
    let note: SeasonStandingNoteModel?
    let team: SeasonStandingTeamModel
    let stats: [SeasonStandingStatsModel]
}

struct SeasonStandingNoteModel: Decodable {
    let description: String
}

struct SeasonStandingTeamModel: Decodable {
    let location: String
    let displayName: String
    let logos: [SeasonStandingTeamLogoModel]
}

struct SeasonStandingStatsModel: Decodable {
    let displayName: String
    let displayValue: String
}

struct SeasonStandingTeamLogoModel: Decodable {
    let href: String
}
