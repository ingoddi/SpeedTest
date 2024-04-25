//
//  MainScreenViewModel.swift
//  SpeedTest
//
//  Created by Иван Карплюк on 24.04.2024.
//

import SwiftUI

@MainActor
final class MainScreenViewModel: ObservableObject {
    @ObservedObject var sharedDataService: SharedDataService
    
    private let router: MainScreenRouter
    private let networkSpeedService: NetworkSpeedServiceProtocol
    private let networkInfoService: NetworkInfoServiceProtocol
    
    init(router: MainScreenRouter, 
         networkSpeedService: NetworkSpeedServiceProtocol,
         networkInfoService: NetworkInfoServiceProtocol,
         sharedDataService: SharedDataService) {
        self.router = router
        self.networkSpeedService = networkSpeedService
        self.networkInfoService = networkInfoService
        self.sharedDataService = sharedDataService
    }
    
    private let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    
    @Published var shouldDownload: Bool = true
    @Published var shouldUpload: Bool = true
    @Published var is_measures: Bool = false
    
    @Published var currentSpeed: Float = 0.0
    @Published var downloadProgress: Float = 0.0
    @Published var averageDownloadSpeed: Float = 0.0
    @Published var uploadProgress: Float = 0.0
    @Published var averageUploadSpeed: Float = 0.0
    
    
    @Published var typeOperationImageName: String = ""
    @Published var typeOperationImageColor: Color = .white
    
    @Published var ip: String = "123"
    @Published var countryName: String = "Bebra"
    @Published var cityName: String = "Govno"
    
    
    private var downloadSpeed: Float = 0.0
    private var uploadSpeed: Float = 0.0
    private var allDownloadSpeeds: [Float] = []
    private var allUploadSpeeds: [Float] = []
    
    func startSpeedTest() {
        if sharedDataService.donwload_is_on {
            downloadFile()
        } else if sharedDataService.upload_is_on {
            uploadFile()
        }
    }
    
    func fetchNetworkInfo() {
        networkInfoService.getNetworkInfo { [weak self] info, error in
            guard let self = self else { return }
            if let error = error {
                print("Error fetching network info: \(error)")
            } else if let info = info {
                print(info.ip)
                DispatchQueue.main.async {
                    self.ip = info.ip
                    self.countryName = info.country_name
                    self.cityName = info.city_name
                }
            }
        }
    }
    
    private func downloadFile() {
        typeOperationImageName = "arrow.down.app"
        typeOperationImageColor = .orange
        
        let destinationURL = documentsURL.appendingPathComponent("test100Mb.db")
        
        networkSpeedService.downloadFile(withURL: sharedDataService.downloadURL, to: destinationURL,
                                         speedCompletion: { speed in
            DispatchQueue.main.async {
                self.downloadSpeed = speed
                self.currentSpeed = speed
                self.allDownloadSpeeds.append(speed)
            }
        }, progressCompletion: { progress in
            self.downloadProgress = progress
        }, completion: { error in
            if let error = error {
                print("Error downloading file: \(error)")
            } else {
                print("Download completed!")
                let totalSpeed = self.allDownloadSpeeds.reduce(0, +)
                self.averageDownloadSpeed = totalSpeed / Float(self.allDownloadSpeeds.count)
                self.allDownloadSpeeds.removeAll()
                self.downloadSpeed = 0
                
                
                do {
                    try FileManager.default.removeItem(at: destinationURL)
                    print("File removed successfully")
                } catch {
                    print("Error removing file: \(error)")
                }
                
                if !self.shouldUpload {
                    self.is_measures.toggle()
                    self.downloadProgress = 0.0
                }
                
                DispatchQueue.main.async {
                    self.currentSpeed = 0.0
                }
                
                if self.shouldUpload {
                    self.uploadFile()
                }
                
            }
        })
    }
    
    private func uploadFile() {
        typeOperationImageName = "arrow.up.square"
        typeOperationImageColor = .red
        
        let data = Data(count: 1024 * 1024 * 100)
        
        networkSpeedService.uploadData(data: data,
                                       toUrl: sharedDataService.uploadURL,
                                       apiKey: "SCTSEM3.GFH6A9B-5H9MEZ0-JSZ4AW3-4G7APPW",
                                       speedCompletion:
                                        { speed in
            DispatchQueue.main.async {
                self.uploadSpeed = speed
                self.currentSpeed = speed
                self.allUploadSpeeds.append(speed)
            }
        }, progressCompletion: { progress in
            self.uploadProgress = progress
        }, completion: { error in
            if let error = error {
                print("Error uploading data: \(error)")
            } else {
                print("Upload completed!")
                let totalSpeed = self.allUploadSpeeds.reduce(0, +)
                self.averageUploadSpeed = totalSpeed / Float(self.allUploadSpeeds.count)
                self.allUploadSpeeds.removeAll()
                self.uploadSpeed = 0
                
                DispatchQueue.main.async {
                    self.currentSpeed = 0.0
                }
    
                self.is_measures.toggle()
                self.downloadProgress = 0.0
                self.uploadProgress = 0.0
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
