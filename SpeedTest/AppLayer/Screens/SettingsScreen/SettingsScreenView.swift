//
//  SettingsScreenView.swift
//  SpeedTest
//
//  Created by Иван Карплюк on 24.04.2024.
//

import SwiftUI

struct SettingsScreenView: View {
    @ObservedObject private var viewModel: SettingsScreenViewModel
    
    init(viewModel: SettingsScreenViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        Text("Settings!")
        TextField("url", text: $viewModel.sharedDataService.url)
        Button("Save", action: {
            
        })
    }
}

