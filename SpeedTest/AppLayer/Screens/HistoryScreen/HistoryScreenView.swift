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
    
    //MARK: - Body
    var body: some View {
        NavigationView {
            List(viewModel.historyEntities, id: \.self) { entity in
                HStack {
                    VStack {
                        Text("\(entity.ip ?? "")")
                            .font(.headline)
                        Text("\(entity.date?.formattedDateString() ?? "")")
                            .font(.footnote)
                    }
                    VStack {
                        Text("Download: \(String(format: "%.1f", entity.averageDownloadSpeed))")
                        Text("Upload: \(String(format: "%.1f", entity.averageUploadSpeed))")
                    }
                }
            }
            .navigationTitle("History")
            .onAppear {
                viewModel.fetchHistoryEntities()
            }
        }
    }
}
