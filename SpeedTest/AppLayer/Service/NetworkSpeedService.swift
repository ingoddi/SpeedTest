//
//  NetworkSpeedService.swift
//  SpeedTest
//
//  Created by Иван Карплюк on 24.04.2024.
//

import Foundation
import Alamofire

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
    
    private var startTime: Date?
    private var previousTime: Date?
    private var previousCompletedCount: Int64 = 0
    
    private var uploadStartTime: Date?
    private var uploadPreviousTime: Date?
    private var uploadPreviousCompletedCount: Int64 = 0
    
    func downloadFile(
        withURL url: String,
        to destinationURL: URL,
        speedCompletion: @escaping (_ speed: Float) -> Void,
        progressCompletion: @escaping (_ percent: Float) -> Void,
        completion: @escaping (_ error: Error?
    ) -> Void) {
        
        self.startTime = Date()
        self.previousTime = Date()
        
        let request = AF.download(url, to: { _, _ -> (destinationURL: URL,
                                                    options: DownloadRequest.Options) in
            (destinationURL: destinationURL, options: [.removePreviousFile, .createIntermediateDirectories])
        })
        
        request.downloadProgress { progress in
            let percent = Float(progress.fractionCompleted)
            progressCompletion(percent)
            
            let currentTime = Date()
            let elapsedTime = currentTime.timeIntervalSince(self.startTime!)
            
            let bytesPerSecond = Float(progress.completedUnitCount) / Float(elapsedTime)
            let speed = bytesPerSecond / (1024 * 1024)
            
            let elapsedInterval = currentTime.timeIntervalSince(self.previousTime!)
            if elapsedInterval > 0.6 || progress.isFinished {
                speedCompletion(speed)
                print("Download speed: \(speed) MB/s")
                self.previousTime = currentTime
                self.previousCompletedCount = progress.completedUnitCount
            }
        }
        
        request.response { response in
            if response.error == nil {
                completion(nil)
            } else {
                completion(response.error)
            }
        }
    }

    func uploadData(
        data: Data,
        toUrl urlString: String,
        apiKey: String,
        speedCompletion: @escaping (_ speed: Float) -> Void,
        progressCompletion: @escaping (_ percent: Float) -> Void,
        completion: @escaping (_ error: Error?) -> Void) {
        
        self.uploadStartTime = Date()
        self.uploadPreviousTime = Date()
        
        let headers: HTTPHeaders = ["X-File-IO-API-Key": apiKey]
        
        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(data, withName: "file", fileName: "testFile", mimeType: "application/octet-stream")
        }, to: urlString, headers: headers).uploadProgress { progress in
            let percent = Float(progress.fractionCompleted)
            progressCompletion(percent)
            
            let currentTime = Date()
            let elapsedTime = currentTime.timeIntervalSince(self.uploadStartTime!)
            
            let bytesPerSecond = Float(progress.completedUnitCount) / Float(elapsedTime)
            let speed = bytesPerSecond / (1024 * 1024)
            
            let elapsedInterval = currentTime.timeIntervalSince(self.uploadPreviousTime!)
            if elapsedInterval > 0.6 || progress.isFinished {
                speedCompletion(speed)
                print("Upload speed: \(speed) MB/s")
                self.uploadPreviousTime = currentTime
                self.uploadPreviousCompletedCount = progress.completedUnitCount
            }
        }.response { response in
            if let error = response.error {
                completion(error)
            } else {
                completion(nil)
            }
        }
    }
}

