//
//  User.swift
//  GCinema
//
//  Created by Edu on 08/03/21.
//

import Foundation

struct User: Codable {
    
    var uID: String?
    var uName: String?
    var uEmail: String?
    var uFavMovieList: [Movie]?
}
