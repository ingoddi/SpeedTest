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
        let networkSpeedService = container.resolve(type: NetworkSpeedServiceProtocol.self)
        let networkInfoService = container.resolve(type: NetworkInfoServiceProtocol.self)
        let sharedDataService = container.resolve(type: SharedDataService.self)
        let coreDataService = container.resolve(type: CoreDataService.self)
        let router = MainScreenRouterImpl()
        let viewModel = MainScreenViewModel(router: router,
                                            networkSpeedService: networkSpeedService, 
                                            networkInfoService: networkInfoService,
                                            sharedDataService: sharedDataService,
                                            coreDataService: coreDataService)
        return MainScreenView(viewModel: viewModel)
    }
}
