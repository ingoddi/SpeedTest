//
//  NetworkSpeedService.swift
//  SpeedTest
//
//  Created by Иван Карплюк on 24.04.2024.
//

import Foundation

protocol NetworkSpeedServiceProtocol {
    func downloadFile(withURL url: String, to destinationURL: URL,
                      speedCompletion: @escaping (_ speed: Float) -> Void,
                      progressCompletion: @escaping (_ percent: Float) -> Void,
                      completion: @escaping (_ error: Error?) -> Void)
    
    func uploadData(data: Data, toUrl urlString: String, apiKey: String,
                    speedCompletion: @escaping (_ speed: Float) -> Void,
                    progressCompletion: @escaping (_ percent: Float) -> Void,
                    completion: @escaping (_ error: Error?) -> Void)
}

final class NetworkSpeedService: NetworkSpeedServiceProtocol {
    func downloadFile(withURL url: String, to destinationURL: URL, speedCompletion: @escaping (Float) -> Void, progressCompletion: @escaping (Float) -> Void, completion: @escaping (Error?) -> Void) {
        //
    }
    
    func uploadData(data: Data, toUrl urlString: String, apiKey: String, speedCompletion: @escaping (Float) -> Void, progressCompletion: @escaping (Float) -> Void, completion: @escaping (Error?) -> Void) {
        //
    }
    
    
}
