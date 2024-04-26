//
//  MainScreenRouter.swift
//  SpeedTest
//
//  Created by Иван Карплюк on 24.04.2024.
//

import Foundation


@MainActor
protocol MainScreenRouter {
    func settingsScreenView() -> SettingsScreenView
    func historyScreenView() -> HistoryScreenView
}

@MainActor
final class MainScreenRouterImpl: ObservableObject {}

extension MainScreenRouterImpl: MainScreenRouter {
    func settingsScreenView() -> SettingsScreenView {
        return SettingsScreenAssembly(container: DIContainer.shared).view()
    }
    
    func historyScreenView() -> HistoryScreenView {
        return HistoryScreenAssembly(container: DIContainer.shared).view()
    }
}
