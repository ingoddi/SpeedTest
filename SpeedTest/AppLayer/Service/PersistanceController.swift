//
//  PersistanceController.swift
//  SpeedTest
//
//  Created by Иван Карплюк on 26.04.2024.
//

import Foundation
import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    let container: NSPersistentContainer

    init() {
        container = NSPersistentContainer(name: "SpeedTest")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                Log.error("Unresolved error \(error), \(error.userInfo)")
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
}
