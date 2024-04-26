//
//  HistoryEntity+CoreDataClass.swift
//  SpeedTest
//
//  Created by Иван Карплюк on 26.04.2024.
//
//

import Foundation
import CoreData

@objc(HistoryEntity)
public class HistoryEntity: NSManagedObject, Identifiable {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<HistoryEntity> {
        return NSFetchRequest<HistoryEntity>(entityName: "HistoryEntity")
    }

    @NSManaged public var date: Date?
    @NSManaged public var averageDownloadSpeed: Float
    @NSManaged public var averageUploadSpeed: Float
    @NSManaged public var ip: String?
    @NSManaged public var as_info: String?
    @NSManaged public var cityName: String?
    @NSManaged public var country: String?
}
