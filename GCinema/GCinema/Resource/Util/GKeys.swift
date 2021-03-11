//
//  GKeys.swift
//  GCinema
//
//  Created by Edu on 09/03/21.
//

import Foundation

struct GKeys {
    
    static let USER_FB_FAV_PATH_KEY = "/Favorites/"
    static let USER_DATA_KEY = "USER_DATA_KEY"
    static let USER_NOTI_COUNT_KEY = "USER_NOTI_COUNT_KEY"
    static let VC_PRESENT_WITH_NAV_TYPE_TAG = 9001
    static let VC_PRESENT_NORMAL_TYPE_TAG = 9002
    static let TABLE_VIEW_BG_IMG_TAG = 7001
    
    //Regex
    static let email    = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    static let pass     = "^.{6,}$"
    static let cpf      = "^.{14,14}$"
    static let cep      = "^.{9,9}$"
    static let phone    = "^.{9,14}$"
    static let cvc      = "^.{3,4}$"
    static let card     = "^.{14,17}$"
}
