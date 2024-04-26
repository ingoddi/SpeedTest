//
//  CoreDataStorageService.swift
//  SpeedTest
//
//  Created by Иван Карплюк on 26.04.2024.
//

import Foundation
import CoreData


final class CoreDataService {
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func saveHistoryEntity(date: Date, 
                           averageDownloadSpeed: Float,
                           averageUploadSpeed: Float,
                           ip: String,
                           as_info: String,
                           cityName: String,
                           country: String) {
        let historyEntity = HistoryEntity(context: context)
        historyEntity.date = date
        historyEntity.averageDownloadSpeed = averageDownloadSpeed
        historyEntity.averageUploadSpeed = averageUploadSpeed
        historyEntity.ip = ip
        historyEntity.as_info = as_info
        historyEntity.cityName = cityName
        historyEntity.country = country
        saveContext()
    }
    
    func fetchAllHistoryEntities() -> [HistoryEntity] {
        let fetchRequest: NSFetchRequest<HistoryEntity> = HistoryEntity.fetchRequest()
        do {
            return try context.fetch(fetchRequest)
        } catch {
            Log.warning("Fetching HistoryEntities Failed")
            return []
        }
    }
    
    func saveSettingEntity(downloadIsOn: Bool,
                           uploadIsOn: Bool,
                           downloadURL: String,
                           uploadURL: String,
                           uploadApiToken: String) {
        // Fetch existing settings entity
        let fetchRequest: NSFetchRequest<SettingEntity> = SettingEntity.fetchRequest()
        do {
            let settingsEntities = try context.fetch(fetchRequest)
            if let settingEntity = settingsEntities.first {
                // If settings entity already exists, update its values
                settingEntity.downloadIsOn = downloadIsOn
                settingEntity.uploadIsOn = uploadIsOn
                settingEntity.downloadURL = downloadURL
                settingEntity.uploadURL = uploadURL
                settingEntity.uploadApiToken = uploadApiToken
            } else {
                // If settings entity does not exist, create a new one
                let settingEntity = SettingEntity(context: context)
                settingEntity.downloadIsOn = downloadIsOn
                settingEntity.uploadIsOn = uploadIsOn
                settingEntity.downloadURL = downloadURL
                settingEntity.uploadURL = uploadURL
                settingEntity.uploadApiToken = uploadApiToken
            }
            saveContext()
        } catch {
            Log.warning("Fetching SettingEntities Failed")
        }
    }
    
    func fetchSettingEntity() -> SettingEntity? {
        let fetchRequest: NSFetchRequest<SettingEntity> = SettingEntity.fetchRequest()
        do {
            let settingsEntities = try context.fetch(fetchRequest)
            return settingsEntities.first
        } catch {
            Log.warning("Fetching SettingEntity Failed")
            return nil
        }
    }
    
    private func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                Log.error("Unresolved error \(nserror), \(nserror.userInfo)")
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
