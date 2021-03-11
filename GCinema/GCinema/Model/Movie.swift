//
//  Movie.swift
//  GCinema
//
//  Created by Edu on 05/03/21.
//

import Foundation

struct Movie: Codable {
    
    var mID: Int?
    var mTitle: String?
    var mOverview: String?
    var mPoster: String?
    var mBackDrop: String?
    var mRanking: Double?
    var isFav: Bool? = false
    var mGenreListID: [Int]? = []
    var mGenreList: [Genre]? = []
    var mCastList: [Cast]? = []
    
    enum CodingKeys: String, CodingKey {
        
        case mID = "id"
        case mTitle = "title"
        case mOverview = "overview"
        case mPoster = "poster_path"
        case mBackDrop = "backdrop_path"
        case mRanking = "vote_average"
        case mGenreListID = "genre_ids"
        case isFav = "isFav"
        case mGenreList = "mGenreList"
        case mCastList = "mCastList"
    }
}

struct ResponseMovieList : Codable {
    
    var movieList: [Movie]?
    
    enum CodingKeys: String, CodingKey {
        case movieList = "results"
    }
}

