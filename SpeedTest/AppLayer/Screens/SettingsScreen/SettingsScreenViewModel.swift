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
    
    ///Функция для обновления URL для загрузки. Это свойство затем используется в других частях приложения, которые требуют этого URL.
    func updateDownloadURL(newURL: String) {
        sharedDataService.downloadURL = newURL
    }
    
    ///Функция для обновления URL для загрузки и токена. Эти свойства затем используются в других частях приложения, которые требуют этого URL и токена.
    func updateUploadURLwithToken(newURL: String, token: String) {
        sharedDataService.uploadURL = newURL
        sharedDataService.uploadApiToken = token
    }
    
    ///Функция для сброса значений URL и токена до их значений по умолчанию. Это может быть полезно, если пользователь хочет сбросить свои настройки.
    func setDefaultValue() {
        sharedDataService.downloadURL = DefaultValueOfURL.defaultDownloadURL
        sharedDataService.uploadURL = DefaultValueOfURL.defaultUploadURL
        sharedDataService.uploadApiToken = DefaultValueOfURL.defaultuploadApiToken
    }
}
