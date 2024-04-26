//
//  NetworkInfoService.swift
//  SpeedTest
//
//  Created by Иван Карплюк on 25.04.2024.
//

import Foundation
import Alamofire

protocol NetworkInfoServiceProtocol {
    func getNetworkInfo(completion: @escaping (_ info: NetworkInfo?, _ error: Error?) -> Void)
}


final class NetworkInfoService: NetworkInfoServiceProtocol {
    
    let networkInfoApiURL = "https://api.ip2location.io/?key=FCB875B677781B30D53AC5A4BD74F92F"
    
    func getNetworkInfo(completion: @escaping (_ info: NetworkInfo?, _ error: Error?) -> Void) {
        AF.request(networkInfoApiURL).responseDecodable(of: NetworkInfo.self) { response in
            switch response.result {
            case .success(let value):
                completion(value, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }

}
