//
//  HistoryScreenAssembly.swift
//  SpeedTest
//
//  Created by Иван Карплюк on 24.04.2024.
//

import Foundation


@MainActor
final class HistoryScreenAssembly {
    private let container: DIContainer
    
    init(container: DIContainer) {
        self.container = container
    }
    
    func view() -> HistoryScreenView {
        let coreDataService = container.resolve(type: CoreDataService.self)
        let router = HistoryScreenRouterImpl()
        let viewModel = HistoryScreenViewModel(router: router, coreDataService: coreDataService)
        return HistoryScreenView(viewModel: viewModel)
    }
}
