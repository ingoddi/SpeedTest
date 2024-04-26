//
//  SharedDataService.swift
//  SpeedTest
//
//  Created by Иван Карплюк on 24.04.2024.
//

import SwiftUI


enum DefaultValueOfURL {
    static let defaultDownloadURL: String = "https://speedtest.selectel.ru/100MB"
    static let defaultUploadURL: String = "https://file.io"
    static let defaultuploadApiToken: String = "SCTSEM3.GFH6A9B-5H9MEZ0-JSZ4AW3-4G7APPW"
}

final class SharedDataService: ObservableObject {
    @Published var downloadURL: String = DefaultValueOfURL.defaultDownloadURL
    @Published var uploadURL: String = DefaultValueOfURL.defaultUploadURL
    @Published var uploadApiToken: String = DefaultValueOfURL.defaultuploadApiToken
     
    @Published var downloadIsOn: Bool = true
    @Published var uploadIsOn: Bool = true
    
}
