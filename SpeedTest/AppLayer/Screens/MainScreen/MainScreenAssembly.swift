//
//  MainScreenAssembly.swift
//  SpeedTest
//
//  Created by Иван Карплюк on 24.04.2024.
//

import Foundation


@MainActor
final class MainScreenAssembly {
    
    private let container: DIContainer
    
    init(container: DIContainer) {
        self.container = container
    }
    
    func view() -> MainScreenView {
        let router = MainScreenRouterImpl()
        let networkSpeedService = container.resolve(type: NetworkSpeedServiceProtocol.self)
        let viewModel = MainScreenViewModel(router: router,
                                            networkSpeedService: networkSpeedService)
        return MainScreenView(viewModel: viewModel)
    }
}
