//
//  LeaguesListConfigurator.swift
//  InStatTest
//
//  Created by andy on 30.06.2022.
//

import Foundation

protocol LeaguesBuilder {
    func build() -> LeaguesViewController
}

final class LeaguesBuilderImpl: LeaguesBuilder {
    func build() -> LeaguesViewController {
        let vc = LeaguesViewController()
        vc.presenter = LeaguesPresenterImpl(
            view: vc,
            displayLeaguesUseCase: DisplayLeaguesUseCaseImpl(
                leaguesGateway: ApiLeaguesGatewayImpl(
                    apiClient: ApiClientImplementation(
                        urlSessionConfiguration: URLSessionConfiguration.default,
                        delegateQueue: OperationQueue.main
                    )
                )
            ),
            router: LeaguesRouterImpl(performer: vc)
        )

        return vc
    }
}
