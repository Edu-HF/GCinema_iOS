//
//  MainService.swift
//  GCinema
//
//  Created by Edu on 05/03/21.
//

/*Dev Comment: I will create only this "MainService" just because the app is small*/

import Foundation
import PromiseKit
import Alamofire

class MainService: BaseService {
    
    //MARK: Movies Methods
    func getMovieList(pageIn: Int?) -> Promise<ResponseMovieList> {
        
        guard let mURL = APIResource.getMovieList.mBaseURL?.appendingPathComponent(APIResource.getMovieList.mWSName) else { return Promise { seal in seal.reject(RequestError.UNError)} }
        
        let params: Parameters = [
            "api_key" : getAPIKey(),
            "page" : pageIn ?? 1
        ]
        
        let request = APIRequest.shared.makeRequest(urlIn: mURL,resourceIn: APIResource.getMovieList, typeIn: ResponseMovieList.self, parametersIn: params, encodingIn: URLEncoding(destination: .queryString), headersIn: buildHeaders())
        return excRequest(requestIn: request)
    }
    
    func getGenreList() -> Promise<ResponseGenreList> {
        
        guard let mURL = APIResource.getGenreList.mBaseURL?.appendingPathComponent(APIResource.getGenreList.mWSName) else { return Promise { seal in seal.reject(RequestError.UNError)} }
        
        let params: Parameters = [
            "api_key" : getAPIKey()
        ]
        
        let request = APIRequest.shared.makeRequest(urlIn: mURL, resourceIn: APIResource.getGenreList, typeIn: ResponseGenreList.self, parametersIn: params, encodingIn: URLEncoding(destination: .queryString), headersIn: buildHeaders())
        return excRequest(requestIn: request)
    }
    
    func getCastList(movieIn: Movie?) -> Promise<ResponseCastList> {
        
        guard var mURL = APIResource.getCastList.mBaseURL?.appendingPathComponent(APIResource.getCastList.mWSName) else { return Promise { seal in seal.reject(RequestError.UNError)} }
        guard let mID = movieIn?.mID else { return Promise { seal in seal.reject(RequestError.UNError)} }
        
        let params: Parameters = [
            "api_key" : getAPIKey()
        ]
        
        mURL.appendPathComponent("\(mID)/credits")
        
        let request = APIRequest.shared.makeRequest(urlIn: mURL, resourceIn: APIResource.getCastList, typeIn: ResponseCastList.self, parametersIn: params, encodingIn: URLEncoding(destination: .queryString), headersIn: buildHeaders())
        return excRequest(requestIn: request)
    }
    
    func getSearchMovieList(pageIn: Int?, queryIn: String?) -> Promise<ResponseMovieList> {
        
        guard let mURL = APIResource.getSearchMovie.mBaseURL?.appendingPathComponent(APIResource.getSearchMovie.mWSName) else { return Promise { seal in seal.reject(RequestError.UNError)} }
        
        let params: Parameters = [
            "api_key" : getAPIKey(),
            "page" : pageIn ?? 1,
            "query" : queryIn ?? ""
        ]
        
        let request = APIRequest.shared.makeRequest(urlIn: mURL,resourceIn: APIResource.getSearchMovie, typeIn: ResponseMovieList.self, parametersIn: params, encodingIn: URLEncoding(destination: .queryString), headersIn: buildHeaders())
        return excRequest(requestIn: request)
    }
    
}
