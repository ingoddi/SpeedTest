//
//  MainScreenViewModel.swift
//  SpeedTest
//
//  Created by Иван Карплюк on 24.04.2024.
//

import SwiftUI

@MainActor
final class MainScreenViewModel: ObservableObject {
    
    //MARK: - Initable
    @ObservedObject var sharedDataService: SharedDataService
    private let router: MainScreenRouter
    private let networkSpeedService: NetworkSpeedServiceProtocol
    private let networkInfoService: NetworkInfoServiceProtocol
    private let coreDataService: CoreDataService
    
    init(router: MainScreenRouter,
         networkSpeedService: NetworkSpeedServiceProtocol,
         networkInfoService: NetworkInfoServiceProtocol,
         sharedDataService: SharedDataService,
         coreDataService: CoreDataService) {
        self.router = router
        self.networkSpeedService = networkSpeedService
        self.networkInfoService = networkInfoService
        self.sharedDataService = sharedDataService
        self.coreDataService = coreDataService
        
        fetchNetworkInfo()
    }
    
    //MARK: - Stored Property
    private lazy var documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    private var downloadSpeed: Float = 0.0
    private var uploadSpeed: Float = 0.0
    private var allDownloadSpeeds: [Float] = []
    private var allUploadSpeeds: [Float] = []
    
    //MARK: - Published Property
    //Bool
    @Published var isMeasuring: Bool = false
    
    //Float
    @Published var currentSpeed: Float = 0.0
    @Published var downloadProgress: Float = 0.0
    @Published var averageDownloadSpeed: Float = 0.0
    @Published var uploadProgress: Float = 0.0
    @Published var averageUploadSpeed: Float = 0.0
    
    //String
    @Published var typeOperationImageName: String = ""
    @Published var ip: String = "Unknown"
    @Published var countryName: String = "Unknown"
    @Published var cityName: String = "Unknown"
    @Published var as_info: String = "Unknown"
    
    //Other
    @Published var typeOperationImageColor: Color = .white
    
    func stopSpeedTest() {
        networkSpeedService.cancelCurrentUpload()
        networkSpeedService.cancelCurrentDownload()
    }
    
    /// Запускает тест скорости сети.
    ///
    /// Эта функция проверяет, включены ли параметры загрузки и выгрузки в `sharedDataService`,
    /// и вызывает соответствующую функцию для выполнения теста.
    func startSpeedTest() {
        if sharedDataService.downloadIsOn {
            downloadFile()
        } else if sharedDataService.uploadIsOn {
            uploadFile()
        }
    }
    
    /// Получает информацию о сети.
    ///
    /// Эта функция использует `networkInfoService` для получения информации о текущей сети.
    /// Полученные данные (IP-адрес, название страны, название города и информация об автономной системе) затем сохраняются в соответствующих свойствах.
    func fetchNetworkInfo() {
        networkInfoService.getNetworkInfo { [weak self] info, error in
            guard let self = self else { return }
            if let error = error {
                Log.error("Error fetching network info: \(error)")
            } else if let info = info {
                DispatchQueue.main.async {
                    self.ip = info.ip
                    self.countryName = info.country_name
                    self.cityName = info.city_name
                    self.as_info = info.as_info
                }
            }
        }
    }
    
    /// Загружает файл для тестирования скорости сети.
    ///
    /// Эта функция выполняет загрузку файла, используя URL, предоставленный `sharedDataService`.
    /// После каждого обновления скорости загрузки и прогресса загрузки, соответствующие свойства обновляются.
    /// После завершения загрузки вычисляется средняя скорость загрузки.
    /// Если была установлена опция выгрузки, функция `uploadFile()` вызывается после завершения загрузки.
    private func downloadFile() {
        // Устанавливаем иконку и цвет для операции загрузки
        typeOperationImageName = "arrow.down.app"
        typeOperationImageColor = .orange
        
        // Определяем местоположение файла назначения
        let destinationURL = documentsURL.appendingPathComponent("test100Mb.db")
        
        // Запускаем загрузку файла
        networkSpeedService.downloadFile(withURL: sharedDataService.downloadURL, to: destinationURL,
                                         // Когда получаем данные о скорости, обновляем свойства
                                         speedCompletion: { speed in
            DispatchQueue.main.async {
                self.downloadSpeed = speed
                self.currentSpeed = speed
                self.allDownloadSpeeds.append(speed)
            }
        }, progressCompletion: { progress in
            // Обновляем прогресс загрузки
            self.downloadProgress = progress
        }, completion: { error in
            // После завершения загрузки обрабатываем возможные ошибки и вычисляем среднюю скорость
            if let error = error {
                Log.warning("Error downloading file: \(error)")
            } else {
                Log.info("Download completed!")
                let totalSpeed = self.allDownloadSpeeds.reduce(0, +)
                self.averageDownloadSpeed = totalSpeed / Float(self.allDownloadSpeeds.count)
                self.allDownloadSpeeds.removeAll()
                self.downloadSpeed = 0
                
                // Удаляем загруженный файл
                do {
                    try FileManager.default.removeItem(at: destinationURL)
                    Log.info("File removed successfully")
                } catch {
                    Log.error("Error removing file: \(error)")
                }
                
                // Если выгрузка не требуется, завершаем измерение
                if !self.sharedDataService.uploadIsOn {
                    self.isMeasuring.toggle()
                    self.downloadProgress = 0.0
                    
                    self.coreDataService.saveHistoryEntity(date: Date(),
                                                           averageDownloadSpeed: self.averageDownloadSpeed,
                                                           averageUploadSpeed: self.averageUploadSpeed,
                                                           ip: self.ip,
                                                           as_info: self.as_info,
                                                           cityName: self.cityName,
                                                           country: self.countryName)
                }
                
                DispatchQueue.main.async {
                    self.currentSpeed = 0.0
                }
                
                // Если выгрузка требуется, запускаем функцию выгрузки
                if self.sharedDataService.uploadIsOn {
                    self.uploadFile()
                }
                
            }
        })
    }
    
    /// Загружает данные для тестирования скорости сети.
    ///
    /// Эта функция выполняет загрузку данных, используя URL, предоставленный `sharedDataService`.
    /// После каждого обновления скорости загрузки и прогресса загрузки, соответствующие свойства обновляются.
    /// После завершения загрузки вычисляется средняя скорость загрузки.
    private func uploadFile() {
        // Устанавливаем иконку и цвет для операции загрузки
        typeOperationImageName = "arrow.up.square"
        typeOperationImageColor = .red
        
        // Создаем данные для загрузки
        let data = Data(count: 1024 * 1024 * 100)
        
        // Запускаем загрузку данных
        networkSpeedService.uploadData(data: data,
                                       toUrl: sharedDataService.uploadURL,
                                       apiKey: sharedDataService.uploadApiToken,
                                       // Когда получаем данные о скорости, обновляем свойства
                                       speedCompletion: { speed in
            DispatchQueue.main.async {
                self.uploadSpeed = speed
                self.currentSpeed = speed
                self.allUploadSpeeds.append(speed)
            }
        }, progressCompletion: { progress in
            // Обновляем прогресс загрузки
            self.uploadProgress = progress
        }, completion: { error in
            // После завершения загрузки обрабатываем возможные ошибки и вычисляем среднюю скорость
            if let error = error {
                Log.error("Error uploading data: \(error)")
            } else {
                Log.info("Upload completed!")
                let totalSpeed = self.allUploadSpeeds.reduce(0, +)
                self.averageUploadSpeed = totalSpeed / Float(self.allUploadSpeeds.count)
                self.allUploadSpeeds.removeAll()
                self.uploadSpeed = 0
                
                DispatchQueue.main.async {
                    self.currentSpeed = 0.0
                }
                
                // Завершаем измерение и сбрасываем прогресс
                self.isMeasuring.toggle()
                self.downloadProgress = 0.0
                self.uploadProgress = 0.0
                
                self.coreDataService.saveHistoryEntity(date: Date(),
                                                       averageDownloadSpeed: self.averageDownloadSpeed,
                                                       averageUploadSpeed: self.averageUploadSpeed,
                                                       ip: self.ip,
                                                       as_info: self.as_info,
                                                       cityName: self.cityName,
                                                       country: self.countryName)
            }
        })
    }
}

// MARK: - Routing
extension MainScreenViewModel {
    func navigateToSettings() -> SettingsScreenView {
        return router.settingsScreenView()
    }
    
    func navigateToHistory() -> HistoryScreenView {
        return router.historyScreenView()
    }
}
