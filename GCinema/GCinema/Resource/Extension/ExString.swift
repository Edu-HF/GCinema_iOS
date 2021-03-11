//
//  ExString.swift
//  GCinema
//
//  Created by Edu on 05/03/21.
//

import Foundation

extension String {
    
    func buildURLStringIMG() -> String? {
        let mainDict = Bundle.main.infoDictionary
        guard let bURL = mainDict?["API_IMG_BASE_URL"] as? String else { return "" }
        return bURL + self
    }
}
