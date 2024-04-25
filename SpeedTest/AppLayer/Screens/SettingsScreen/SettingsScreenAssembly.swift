//
//  SettingsScreenAssembly.swift
//  SpeedTest
//
//  Created by Иван Карплюк on 24.04.2024.
//

import Foundation

@MainActor
final class SettingsScreenAssembly {
    
    private let container: DIContainer
    
    init(container: DIContainer) {
        self.container = container
    }
    func view() -> SettingsScreenView {
        let sharedDataService = container.resolve(type: SharedDataService.self)
        
        let router = SettingsScreenRouterImpl()
        let viewModel = SettingsScreenViewModel(router: router,
                                                sharedDataService: sharedDataService)
        return SettingsScreenView(viewModel: viewModel)
    }
}
