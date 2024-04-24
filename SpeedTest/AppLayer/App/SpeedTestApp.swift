//
//  SpeedTestApp.swift
//  SpeedTest
//
//  Created by Иван Карплюк on 24.04.2024.
//

import SwiftUI

@main
struct SpeedTestApp: App {
    
    
    
    private func registerServices() {
        DIContainer.shared.register(type: NetworkSpeedServiceProtocol.self, service: NetworkSpeedService())
    }
    
    var body: some Scene {
        WindowGroup {
            MainScreenAssembly(container: DIContainer.shared).view()
                .onAppear(perform: registerServices)
        }
    }
}
