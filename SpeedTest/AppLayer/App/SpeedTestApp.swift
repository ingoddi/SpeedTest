//
//  SpeedTestApp.swift
//  SpeedTest
//
//  Created by Иван Карплюк on 24.04.2024.
//

import SwiftUI

@main
struct SpeedTestApp: App {
    
    private var sharedDataService: SharedDataService = SharedDataService()
        
    init() {
        registerServices()
        
    }
    
    private func registerServices() {
        DIContainer.shared.register(type: NetworkSpeedServiceProtocol.self, service: NetworkSpeedService())
        DIContainer.shared.register(type: NetworkInfoServiceProtocol.self, service: NetworkInfoService())
        DIContainer.shared.register(type: SharedDataService.self, service: sharedDataService)
    }
    
    var body: some Scene {
        WindowGroup {
            MainScreenAssembly(container: DIContainer.shared).view()
        }
    }
}
