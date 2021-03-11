//
//  ExUIColor.swift
//  GCinema
//
//  Created by Edu on 03/03/21.
//

import Foundation
import UIKit

extension UIColor {
    
    @nonobjc class var swipeBGColor: UIColor {
        return UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 0.0)
    }
    
    @nonobjc class var baseAppColor: UIColor {
        return UIColor().fromHex(0x2B2F3D)
    }
    
    @nonobjc class var orangeColor: UIColor {
        return UIColor().fromHex(0xFF6B00)
    }
    
    @nonobjc class var redColor: UIColor {
        return UIColor().fromHex(0xEC4F4F)
    }
    
    @nonobjc class var blackColor: UIColor {
        return UIColor().fromHex(0x1A1D23)
    }
    
    @nonobjc class var darkColor: UIColor {
        return UIColor().fromHex(0x393D4C)
    }
    
    func fromHex(_ rgbValue:UInt32, alpha:Double=1.0) -> UIColor {
        
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        
        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }
}
