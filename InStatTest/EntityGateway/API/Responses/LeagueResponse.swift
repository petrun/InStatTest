//
//  LeagueResponse.swift
//  InStatTest
//
//  Created by andy on 30.06.2022.
//

import Foundation

struct LeagueResponse: Decodable {
    let status: Bool
    let data: [LeagueModel]
}
