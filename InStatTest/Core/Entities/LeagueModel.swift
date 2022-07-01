//
//  LeagueModel.swift
//  InStatTest
//
//  Created by andy on 30.06.2022.
//

import Foundation

struct LeagueModel: Decodable {
    let id: String
    let name: String
    let slug: String
    let abbr: String
    let logos: LeagueLogosModel
}

struct LeagueLogosModel: Decodable {
    let light: String
    let dark: String
}
