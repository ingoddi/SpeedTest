//
//  MainScreenView.swift
//  SpeedTest
//
//  Created by Иван Карплюк on 24.04.2024.
//

import SwiftUI

struct MainScreenView: View {
    @ObservedObject private var viewModel: MainScreenViewModel
    
    init(viewModel: MainScreenViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Text("\(viewModel.sharedDataService.url)")
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack {
                        NavigationLink(destination: viewModel.navigateToHistory()) {
                            Image(systemName: "book")
                        }
                        NavigationLink(destination: viewModel.navigateToSettings()) {
                            Image(systemName: "gear")
                        }
                    }
                }
            }
        }
    }
}

