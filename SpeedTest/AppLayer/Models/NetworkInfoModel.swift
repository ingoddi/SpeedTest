//
//  NetworkInfoModel.swift
//  SpeedTest
//
//  Created by Иван Карплюк on 25.04.2024.
//

import Foundation


struct NetworkInfo: Codable {
    let ip: String
    let country_code: String
    let country_name: String
    let region_name: String
    let city_name: String
    let latitude: Double
    let longitude: Double
    let zip_code: String
    let time_zone: String
    let asn: String
    let as_info: String
    let is_proxy: Bool

    // Переопределяем ключи для корректного парсинга JSON
    enum CodingKeys: String, CodingKey {
        case ip
        case country_code
        case country_name
        case region_name
        case city_name
        case latitude
        case longitude
        case zip_code
        case time_zone
        case asn
        case as_info = "as"
        case is_proxy
    }
}
