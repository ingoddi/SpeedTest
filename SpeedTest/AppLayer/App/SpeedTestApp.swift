//
//  SpeedTestApp.swift
//  SpeedTest
//
//  Created by Иван Карплюк on 24.04.2024.
//

import SwiftUI


final class AppServices: ObservableObject {
    var coreDataSerivce: CoreDataService
    var sharedDataService: SharedDataService
    
    init() {
        let persistenceController = PersistenceController.shared
        coreDataSerivce = CoreDataService(context: persistenceController.container.viewContext)
        sharedDataService = SharedDataService()
        
        registerServices()
        loadSharedData()
    }
    
    private func registerServices() {
        DIContainer.shared.register(type: NetworkSpeedServiceProtocol.self, service: NetworkSpeedService())
        DIContainer.shared.register(type: NetworkInfoServiceProtocol.self, service: NetworkInfoService())
        DIContainer.shared.register(type: SharedDataService.self, service: sharedDataService)
        DIContainer.shared.register(type: CoreDataService.self, service: coreDataSerivce)
    }
    
    private func loadSharedData() {
        let sharedData = coreDataSerivce.fetchSettingEntity()
        sharedDataService.downloadURL = sharedData?.downloadURL ?? DefaultValueOfURL.defaultDownloadURL
        sharedDataService.uploadURL = sharedData?.uploadURL ?? DefaultValueOfURL.defaultUploadURL
        sharedDataService.uploadApiToken = sharedData?.uploadApiToken ?? DefaultValueOfURL.defaultuploadApiToken
        sharedDataService.downloadIsOn = sharedData?.downloadIsOn ?? true
        sharedDataService.uploadIsOn = sharedData?.uploadIsOn ?? true
    }
    
    func saveSharedData() {
        coreDataSerivce.saveSettingEntity(downloadIsOn: sharedDataService.downloadIsOn,
                                          uploadIsOn: sharedDataService.uploadIsOn,
                                          downloadURL: sharedDataService.downloadURL,
                                          uploadURL: sharedDataService.uploadURL,
                                          uploadApiToken: sharedDataService.uploadApiToken)
    }
}

@main
struct SpeedTestApp: App {
    @Environment(\.scenePhase) var scenePhase
    @ObservedObject private var services = AppServices()
    
    var body: some Scene {
        WindowGroup {
            MainScreenAssembly(container: DIContainer.shared).view()
        }.onChange(of: scenePhase) { newScenePhase in
            switch newScenePhase {
            case .active:
                print("🔆 - App is active")
            case .inactive, .background:
                print("💤 - App is inactive or in background")
                services.saveSharedData()
            @unknown default:
                print("🌀 - Unknown scene phase")
            }
        }
    }
}
