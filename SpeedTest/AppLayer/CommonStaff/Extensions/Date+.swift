//
//  Date+.swift
//  SpeedTest
//
//  Created by Иван Карплюк on 24.04.2024.
//

import Foundation


extension Date {
    func toString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy hh:mm"
        return dateFormatter.string(from: self)
    }
}

extension Date {
    func formattedDateString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy HH:mm"
        return formatter.string(from: self)
    }
}
