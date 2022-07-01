//
//  SeasonStandingsRouter.swift
//  InStatTest
//
//  Created by andy on 01.07.2022.
//

import Foundation

protocol SeasonStandingsRouter {
    func dismissView()
}

struct SeasonStandingsRouterImpl: SeasonStandingsRouter {
    private weak var performer: SeasonStandingsViewController?

    init(performer: SeasonStandingsViewController) {
        self.performer = performer
    }

    func dismissView() {
        let _ = performer?.navigationController?.popViewController(animated: true)
    }
}
