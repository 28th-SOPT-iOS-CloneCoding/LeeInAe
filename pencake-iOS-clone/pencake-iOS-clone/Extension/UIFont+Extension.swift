//
//  UIFont+Extension.swift
//  pencake-iOS-clone
//
//  Created by inae Lee on 2021/05/25.
//

import UIKit

extension UIFont {
    class func NotoSerifKR(type: NotoSerifKRType, size: CGFloat) -> UIFont {
        guard let font = UIFont(name: type.name, size: size) else {return UIFont.init()}
        
        return font
    }

    enum NotoSerifKRType: String {
        case bold = "Bold"
        case light = "Light"
        case medium = "Medium"
        case regular = "Regular"
        case semiBold = "semiBold"
        
        var name: String {
            return "NotoSerifKR-" + self.rawValue
        }
    }
}
