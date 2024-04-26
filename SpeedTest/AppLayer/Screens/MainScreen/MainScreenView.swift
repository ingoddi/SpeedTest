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
    
    //MARK: - Body
    var body: some View {
        NavigationView {
            VStack {
                networkStatView
                    .padding()
                currentSpeedView
                    .padding()
                Spacer()
                speedometr
                Spacer()
                speedStat
                    .padding()
                Spacer()
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    toolBarItem
                }
            }
        }
    }
    
    // MARK: - SpeedStat View
    private var speedStat: some View {
        HStack(spacing: 20) {
            VStack {
                HStack(spacing: 5) {
                    Image(systemName: "arrow.down.app")
                        .resizable()
                        .foregroundColor(.orange)
                        .frame(width: 20, height: 20)
                    Text("DOWNLOAD")
                        .bold()
                    Text("Mb/s")
                        .foregroundColor(.gray)
                }
                Text(String(format: "%.1f", viewModel.averageDownloadSpeed))
                    .font(.largeTitle)
                    .shadow(radius: 1)
            }
            
            VStack {
                HStack(spacing: 5) {
                    Image(systemName: "arrow.up.square")
                        .resizable()
                        .foregroundColor(.red)
                        .frame(width: 20, height: 20)
                    Text("UPLOAD")
                        .bold()
                    Text("Mb/s")
                        .foregroundColor(.gray)
                }
                Text(String(format: "%.1f", viewModel.averageUploadSpeed))
                    .font(.largeTitle)
                    .shadow(radius: 1)
            }
        }
    }
    
    // MARK: - Speedometr View
    private var speedometr: some View {
        VStack {
            if !viewModel.isMeasuring {
                withAnimation {
                    StartButton(bool: $viewModel.isMeasuring, 
                                width: 150,
                                heght: 150)
                        .transition(.scale)
                        .onAppear {
                            viewModel.fetchNetworkInfo()
                        }
                }
            } else {
                withAnimation {
                    ZStack{
                        SpeedoMeter(progress: $viewModel.downloadProgress, 
                                    colors: [.yellow, .orange],
                                    width: 280,
                                    height: 280)
                        SpeedoMeter(progress: $viewModel.uploadProgress, 
                                    colors: [.orange, .red],
                                    width: 180,
                                    height: 180)
                    }
                    .transition(.scale)
                    .onAppear {
                        viewModel.startSpeedTest()
                    }
                }
            }
        }
        .padding()
    }
    
    // MARK: - Current View
    private var currentSpeedView: some View {
        HStack {
            if viewModel.isMeasuring {
                withAnimation {
                    Image(systemName: "\(viewModel.typeOperationImageName)")
                        .resizable()
                        .foregroundColor(viewModel.typeOperationImageColor)
                        .frame(width: 60, height: 60)
                        .transition(.opacity)
                }
            }
            
            
            VStack(spacing: 60) {
                Text(String(format: "%.1f Mb/s", viewModel.currentSpeed))
                    .fontWeight(.semibold)
                    .font(.largeTitle)
            }
        }
    }
    
    // MARK: - NetworkStat View
    private var networkStatView: some View {
        HStack {
            HStack {
                VStack(alignment: .trailing) {
                    Text("\(viewModel.ip)")
                        .font(.headline)
                    Text("\(viewModel.as_info)")
                        .font(.footnote)
                        .lineLimit(2)
                }
            }
            
            Spacer()
            
            HStack {
                VStack(alignment: .leading) {
                    Text("\(viewModel.cityName)")
                        .font(.headline)
                    Text("\(viewModel.countryName)")
                        .font(.footnote)
                }
            }
            
        }
    }
    
    // MARK: - Toolbar View
    private var toolBarItem: some View {
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

