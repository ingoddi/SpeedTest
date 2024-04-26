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
    private let coreDataService: CoreDataService
    
    @Published var historyEntities: [HistoryEntity] = []
    
    init(router: HistoryScreenRouter,
         coreDataService: CoreDataService) {
        self.router = router
        self.coreDataService = coreDataService
        
        fetchHistoryEntities()
    }
    
    ///Fetch HistoryEntity и присвоение Published
    func fetchHistoryEntities() {
        historyEntities = coreDataService.fetchAllHistoryEntities()
    }
}
