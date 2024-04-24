//
//  MainScreenViewModel.swift
//  SpeedTest
//
//  Created by Иван Карплюк on 24.04.2024.
//

import Foundation

@MainActor
final class MainScreenViewModel: ObservableObject {
    
    var sharedDataService = SharedDataService.share
    
    private let router: MainScreenRouter
    private let networkSpeedService: NetworkSpeedServiceProtocol
    
    
    init(router: MainScreenRouter, networkSpeedService: NetworkSpeedServiceProtocol) {
        self.router = router
        self.networkSpeedService = networkSpeedService
    }
    
    func navigateToSettings() -> SettingsScreenView {
        return router.settingsScreenView()
    }
    
    func navigateToHistory() -> HistoryScreenView {
        return router.historyScreenView()
    }
    
}
