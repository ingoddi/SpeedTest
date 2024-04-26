//
//  SettingEntity+CoreDataClass.swift
//  SpeedTest
//
//  Created by Иван Карплюк on 26.04.2024.
//
//

import Foundation
import CoreData

@objc(SettingEntity)
public class SettingEntity: NSManagedObject, Identifiable {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<SettingEntity> {
        return NSFetchRequest<SettingEntity>(entityName: "SettingEntity")
    }

    @NSManaged public var downloadIsOn: Bool
    @NSManaged public var uploadIsOn: Bool
    @NSManaged public var downloadURL: String?
    @NSManaged public var uploadURL: String?
    @NSManaged public var uploadApiToken: String?
}

