//
//  APIResource.swift
//  GCinema
//
//  Created by Edu on 05/03/21.
//

import Foundation
import Alamofire

//MARK: Protocols
protocol EndPointType {
    var mBaseURL: URL? { get }
    var mWSName: String { get }
}

//MARK: Structs
struct APIError: Codable {
    let onSuccess: Bool
    let onError: APIErrorDetail
}

struct APIErrorDetail: Codable {
    let message, name: String
    let code: Int
}

//MARK: Enums
enum APIResource {
    case getMovieList, getGenreList, getCastList, getSearchMovie
}

//MARK: Extension
extension APIResource: EndPointType {
    
    var mBaseURL: URL? {
        let mDict = Bundle.main.infoDictionary
        let mURL = mDict?["SERVER_URL"] as? String
        return URL(string: mURL ?? "")
    }
    
    var mWSName: String {
        
        switch self {
            
        case .getMovieList:     return "/movie/now_playing"
        case .getGenreList:     return "/genre/movie/list"
        case .getCastList:      return "/movie/"
        case .getSearchMovie:   return "/search/movie"
        
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getMovieList, .getGenreList, .getCastList, .getSearchMovie: return .get
        }
    }
}

