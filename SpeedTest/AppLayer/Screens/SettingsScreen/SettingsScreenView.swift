//
//  SettingsScreenView.swift
//  SpeedTest
//
//  Created by Иван Карплюк on 24.04.2024.
//

import SwiftUI

struct SettingsScreenView: View {
    @ObservedObject private var viewModel: SettingsScreenViewModel
    
    @State private var downloadURL: String = ""
    @State private var uploadURL: String = ""
    @State private var uploadAPIToken: String = ""
    
    @State private var isAlertShown: Bool = false
    @State private var alertMessage: String = ""
    
    
    init(viewModel: SettingsScreenViewModel) {
        self.viewModel = viewModel
    }
    
    //MARK: - Body
    var body: some View {
        NavigationView {
            VStack {
                toggleSection
                    .padding()
                downloadURLChanging
                uploadURLChanging
                    .padding()
                Spacer()
                defaultDataButton
            }
            .navigationTitle("Settings")
            .alert(isPresented: $isAlertShown) {
                Alert(
                    title: Text("Success"),
                    message: Text(alertMessage),
                    dismissButton: .default(Text("OK")) {
                        downloadURL = ""
                        uploadURL = ""
                        uploadAPIToken = ""
                    }
                )
            }
        }
    }
    
    // MARK: - Toggle Section View
    private var toggleSection: some View {
        VStack{
            Toggle("Download test", isOn: $viewModel.sharedDataService.downloadIsOn)
                .toggleStyle(SwitchToggleStyle(tint: .orange))
            Toggle("Upload test", isOn: $viewModel.sharedDataService.uploadIsOn)
                .toggleStyle(SwitchToggleStyle(tint: .orange))
        }
    }
    
    // MARK: - Download URL Changing View
    private var downloadURLChanging: some View {
        VStack {
            TextField("Download URL", text: $downloadURL)
                .padding(.bottom, 10)
                .overlay(
                    Rectangle()
                        .frame(height: 1)
                        .padding(.top)
                        .foregroundColor(.gray),
                    alignment: .bottom
                )
            Button("Save", action: {
                viewModel.updateDownloadURL(newURL: downloadURL)
                alertMessage = "Download URL has been saved successfully."
                isAlertShown = true
            })
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 35)
            .background(Color.orange)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .padding()
    }
    
    // MARK: - Upload URL Changing View
    private var uploadURLChanging: some View {
        VStack {
            TextField("Upload URL", text: $uploadURL)
                .padding(.bottom, 10)
                .overlay(
                    Rectangle()
                        .frame(height: 1)
                        .padding(.top)
                        .foregroundColor(.gray),
                    alignment: .bottom
                )
            TextField("Upload API-token", text: $uploadAPIToken)
                .padding(.bottom, 10)
                .overlay(
                    Rectangle()
                        .frame(height: 1)
                        .padding(.top)
                        .foregroundColor(.gray),
                    alignment: .bottom
                )
            Button("Save", action: {
                viewModel.updateUploadURLwithToken(newURL: uploadURL, token: uploadAPIToken)
                alertMessage = "Upload URL and API token have been saved successfully."
                isAlertShown = true
            })
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 35)
            .background(Color.orange)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
    }
    
    // MARK: - Default Date Button View
    private var defaultDataButton: some View {
        Button("Default value", action: {
            viewModel.setDefaultValue()
            alertMessage = "Default values have been restored successfully."
            isAlertShown = true
        })
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 35)
        .background(Color.red)
        .foregroundColor(.white)
        .cornerRadius(10)
        .padding()
    }
}

