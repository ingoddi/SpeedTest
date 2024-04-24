//
//  HistortScreenView.swift
//  SpeedTest
//
//  Created by Иван Карплюк on 24.04.2024.
//

import SwiftUI

struct HistoryScreenView: View {
    @ObservedObject private var viewModel: HistoryScreenViewModel
    
    init(viewModel: HistoryScreenViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        Text("History")
    }
}
