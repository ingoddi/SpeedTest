//
//  HistoryScreenAssembly.swift
//  SpeedTest
//
//  Created by Иван Карплюк on 24.04.2024.
//

import Foundation


@MainActor
final class HistoryScreenAssembly {
    func view() -> HistoryScreenView {
        let router = HistoryScreenRouterImpl()
        let viewModel = HistoryScreenViewModel(router: router)
        return HistoryScreenView(viewModel: viewModel)
    }
}
