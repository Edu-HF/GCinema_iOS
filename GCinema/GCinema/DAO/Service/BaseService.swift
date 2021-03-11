//
//  BaseService.swift
//  GCinema
//
//  Created by Edu on 05/03/21.
//

import Foundation
import Alamofire
import PromiseKit

class BaseService {
    
    //MARK: Static Func
    func buildHeaders() -> HTTPHeaders {
        let headers: HTTPHeaders  = [
            "Content-Type" : "application/x-www-form-urlencoded",
            "Accept": "application/json",
            "api_key": getAPIKey()
        ]
        return headers
    }
    
    func getAPIKey() -> String {
        var apiKey: String {
            let mainDict = Bundle.main.infoDictionary
            return mainDict?["API_KEY"] as! String
        }
        
        return apiKey
    }
    
    //MARK: Public Methods
    func excRequest<T: Codable>(requestIn: Promise<T>) -> Promise<T> {
        return Promise { seal in
            requestIn.done { response in
                seal.fulfill(response)
                }.catch { error in
                    return seal.reject(error)
            }
        }
    }
}
