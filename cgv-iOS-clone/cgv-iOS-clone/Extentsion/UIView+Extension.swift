//
//  UIView+Extension.swift
//  cgv-iOS-clone
//
//  Created by inae Lee on 2021/05/11.
//

import UIKit

extension UIView {
    func addSubviews(_ views: [UIView]) {
        views.forEach { self.addSubview($0) }
    }
}
