//
//  Cast.swift
//  GCinema
//
//  Created by Edu on 06/03/21.
//

import Foundation

struct Cast: Codable {
    
    var cID: Int?
    var cName: String?
    var cRealName: String?
    var cDepartment: String?
    var cCharacter: String?
    var cProfilePath: String?
    
    enum CodingKeys: String, CodingKey {
        
        case cID = "id"
        case cName = "name"
        case cRealName = "original_name"
        case cDepartment = "known_for_department"
        case cCharacter = "character"
        case cProfilePath = "profile_path"
    }
}

struct ResponseCastList : Codable {
    
    var castList: [Cast]?
    
    enum CodingKeys: String, CodingKey {
        case castList = "cast"
    }
}
