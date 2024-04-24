//
//  SettingsScreenViewModel.swift
//  SpeedTest
//
//  Created by Иван Карплюк on 24.04.2024.
//

import Foundation

@MainActor
final class SettingsScreenViewModel: ObservableObject {
    
    var sharedDataService = SharedDataService.share
    
    private let router: SettingsScreenRouter
    
    init(router: SettingsScreenRouter) {
        self.router = router
    }
}
