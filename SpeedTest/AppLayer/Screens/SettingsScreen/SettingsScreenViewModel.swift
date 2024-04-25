//
//  SettingsScreenViewModel.swift
//  SpeedTest
//
//  Created by Иван Карплюк on 24.04.2024.
//

import SwiftUI

@MainActor
final class SettingsScreenViewModel: ObservableObject {
    private let router: SettingsScreenRouter
    
    @ObservedObject var sharedDataService: SharedDataService
        
    init(router: SettingsScreenRouter,
         sharedDataService: SharedDataService) {
        self.router = router
        self.sharedDataService = sharedDataService
    }
    
    func updateURL(newURL: String) {
        sharedDataService.downloadURL = newURL
    }
}
