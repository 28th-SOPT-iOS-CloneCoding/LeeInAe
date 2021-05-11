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

    func cornerRounds() {
        print("🧡", self.layer.frame.height)
        self.layer.cornerRadius = self.layer.frame.height / 2
        self.layer.masksToBounds = true
    }

    func cornerRound(radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
}
