//
//  String+Extension.swift
//  cgv-iOS-clone
//
//  Created by inae Lee on 2021/05/12.
//

import UIKit

extension String {
    func commaToNumbers(num: Int) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal

        return numberFormatter.string(from: NSNumber(value: num)) ?? String(num)
    }
}
