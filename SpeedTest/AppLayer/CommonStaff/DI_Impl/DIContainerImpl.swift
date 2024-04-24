//
//  DIContainer.swift
//  SpeedTest
//
//  Created by Иван Карплюк on 24.04.2024.
//

import Foundation


final class DIContainer: DICprotocol {
    var services: [String : Any]
    
    static var shared = DIContainer()
    
    private init () { services = [:] }
}
