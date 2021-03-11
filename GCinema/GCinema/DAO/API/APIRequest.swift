//
//  APIRequest.swift
//  GCinema
//
//  Created by Edu on 05/03/21.
//

import Foundation
import PromiseKit
import Alamofire
import SwiftyJSON

enum RequestError: Error {
    case APIError(String)
    case UNError
    case ErrorParsing
}

class APIRequest: NSObject {
    
    //MARK: Shared Instance
    static let shared = APIRequest()
    
    //MARK: Main Make Request Method
    func makeRequest<T: Codable>(urlIn: URL, resourceIn: APIResource, typeIn: T.Type, parametersIn: Parameters? = nil, encodingIn: URLEncoding? = nil, headersIn: HTTPHeaders? = nil) -> Promise<T> {
        
        var mainRequest: DataRequest!
        self.mLog("MAIN URL: ", urlIn)
        mainRequest = AF.request(urlIn, method: resourceIn.method, parameters: parametersIn, headers: headersIn)
        
        return Promise { seal in
            mainRequest
                .validate()
                .responseJSON(queue: DispatchQueue.global(qos: .userInitiated)) { response in
       
                    guard let dataResponse = response.data else { return seal.reject(RequestError.UNError) }
                    
                    if let dataResult = self.makeDecode(typeIn, dataResponse) {
                        self.mLog("MAIN API RESPONSE: ", dataResult)
                        return seal.fulfill(dataResult)
                    }else{
                        return seal.reject(RequestError.UNError)
                    }
            }
        }
    }
}

class EZConnectivity {
    class var isConnedToInternet: Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
}

