//
//  DataController.swift
//  SpeedTest
//
//  Created by Иван Карплюк on 24.04.2024.
//

import CoreData


final class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "SpeedTest")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                Log.error("Core data failed to load: \(error.localizedDescription)")
            }
        }
    }
    
}
