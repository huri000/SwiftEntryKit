//
//  UIColor+Utils.swift
//  SwiftEntryKit
//
//  Created by Daniel Huri on 4/20/18.
//  Copyright (c) 2018 huri000@gmail.com. All rights reserved.
//

import UIKit

extension UIColor {
    static func by(r: Int, g: Int, b: Int, a: CGFloat = 1) -> UIColor {
        let d = CGFloat(255)
        return UIColor(red: CGFloat(r) / d, green: CGFloat(g) / d, blue: CGFloat(b) / d, alpha: a)
    }
    
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
    
    static let darkDefault = UIColor(white: 45.0/255.0, alpha: 1)
    static let grayText = UIColor(white: 160.0/255.0, alpha: 1)
    static let facebookDarkBlue = UIColor.by(r: 59, g: 89, b: 152)
    static let dimmedLightBackground = UIColor(white: 100.0/255.0, alpha: 0.3)
    static let dimmedDarkBackground = UIColor(white: 50.0/255.0, alpha: 0.3)
    static let pinky = UIColor(rgb: 0xE91E63)
    static let amber = UIColor(rgb: 0xFFC107)
    static let satCyan = UIColor(rgb: 0x00BCD4)
    static let darkText = UIColor(rgb: 0x212121)
    static let redish = UIColor(rgb: 0xFF5252)
    static let darkSubText = UIColor(rgb: 0x757575)
    static let greenGrass = UIColor(rgb: 0x4CAF50)
    static let darkChatMessage = UIColor(red: 48, green: 47, blue: 48)
}

struct EKColor {
    struct BlueGray {
        static let c50 = UIColor(rgb: 0xeceff1)
        static let c100 = UIColor(rgb: 0xcfd8dc)
        static let c200 = UIColor(rgb: 0xb0bec5)
        static let c300 = UIColor(rgb: 0x90a4ae)
        static let c400 = UIColor(rgb: 0x78909c)
        static let c500 = UIColor(rgb: 0x607d8b)
        static let c600 = UIColor(rgb: 0x546e7a)
        static let c700 = UIColor(rgb: 0x455a64)
        static let c800 = UIColor(rgb: 0x37474f)
        static let c900 = UIColor(rgb: 0x263238)
    }
    
    struct Netflix {
        static let light = UIColor(rgb: 0x485563)
        static let dark = UIColor(rgb: 0x29323c)
    }
    
    struct Gray {
        static let a800 = UIColor(rgb: 0x424242)
        static let mid = UIColor(rgb: 0x616161)
        static let light = UIColor(white: 230.0/255.0, alpha: 1)
    }
    
    struct Purple {
        static let a300 = UIColor(rgb: 0xba68c8)
        static let a400 = UIColor(rgb: 0xab47bc)
        static let a700 = UIColor(rgb: 0xaa00ff)
        static let deep = UIColor(rgb: 0x673ab7)
    }
    
    struct BlueGradient {
        static let light = UIColor(red: 100, green: 172, blue: 196)
        static let dark = UIColor(red: 27, green: 47, blue: 144)
    }
    
    struct Yellow {
        static let a700 = UIColor(rgb: 0xffd600)
    }
    
    struct Teal {
        static let a700 = UIColor(rgb: 0x00bfa5)
        static let a600 = UIColor(rgb: 0x00897b)
    }
    
    struct Orange {
        static let a50 = UIColor(rgb: 0xfff3e0)
    }
    
    struct LightBlue {
        static let a700 = UIColor(rgb: 0x0091ea)
    }
    
    struct LightPink {
        static let first = UIColor(rgb: 0xff9a9e)
        static let last = UIColor(rgb: 0xfad0c4)
    }
}
