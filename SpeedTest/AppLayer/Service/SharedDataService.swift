//
//  SharedDataService.swift
//  SpeedTest
//
//  Created by Иван Карплюк on 24.04.2024.
//

import SwiftUI


final class SharedDataService: ObservableObject {
    @Published var downloadURL: String = "https://speedtest.selectel.ru/100MB"
    @Published var uploadURL: String = "https://file.io"
    
    @Published var donwload_is_on: Bool = true
    @Published var upload_is_on: Bool = true
    
}
