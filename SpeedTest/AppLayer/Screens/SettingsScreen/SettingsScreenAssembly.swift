//
//  SettingsScreenAssembly.swift
//  SpeedTest
//
//  Created by Иван Карплюк on 24.04.2024.
//

import Foundation

@MainActor
final class SettingsScreenAssembly {
    func view() -> SettingsScreenView {
        let router = SettingsScreenRouterImpl()
        let viewModel = SettingsScreenViewModel(router: router)
        return SettingsScreenView(viewModel: viewModel)
    }
}
