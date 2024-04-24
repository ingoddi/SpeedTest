//
//  SharedDataService.swift
//  SpeedTest
//
//  Created by Иван Карплюк on 24.04.2024.
//

import Foundation


@MainActor
final class SharedDataService: ObservableObject {
    
    static let share = SharedDataService()
    
    @Published var url: String = ""
    
    private init() { }
}
