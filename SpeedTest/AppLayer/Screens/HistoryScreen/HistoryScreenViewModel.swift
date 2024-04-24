//
//  HistoryScreenViewModel.swift
//  SpeedTest
//
//  Created by Иван Карплюк on 24.04.2024.
//

import Foundation

@MainActor
final class HistoryScreenViewModel: ObservableObject {
    private var router: HistoryScreenRouter
    
    init(router: HistoryScreenRouter) {
        self.router = router
    }
}
