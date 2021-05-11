//
//  UIFont+Extension.swift
//  cgv-iOS-clone
//
//  Created by inae Lee on 2021/05/11.
//

import UIKit

extension UIFont {
    class func AppleSDGothic(type: AppleSDGothicType, size: CGFloat) -> UIFont! {
        guard let font = UIFont(name: type.name, size: size) else {
            return nil
        }
        return font
    }

    public enum AppleSDGothicType {
        case semiBold
        case regular
        case light

        var name: String {
            switch self {
            case .regular:
                return "AppleSDGothicNeo-Regular"
            case .semiBold:
                return "AppleSDGothicNeo-SemiBold"
            case .light:
                return "AppleSDGothicNeo-Light"
            }
        }
    }
}
