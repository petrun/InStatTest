//
//  LeagueSeasonTableViewCell.swift
//  InStatTest
//
//  Created by andy on 01.07.2022.
//

import UIKit

final class LeagueSeasonTableViewCell: UITableViewCell {

    static let id = "LeagueSeasonTableViewCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LeagueSeasonTableViewCell: LeagueSeasonCellView {
    func display(title: String) {
        textLabel?.text = title
    }
}
