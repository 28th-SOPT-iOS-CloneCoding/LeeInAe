//
//  RadioButtonCell.swift
//  reminder-iOS-clone
//
//  Created by inae Lee on 2021/04/23.
//

import UIKit

class RadioButtonCell: UICollectionViewCell {
    static let identifier = "RadioButtonCell"

    @IBOutlet var colorButton: RadioButton!

    // FIXME: - 스크롤에 따라 isSelected값이 변경됨
    override var isSelected: Bool {
        didSet {
            if isSelected {
                colorButton.touchUpButton()
            } else {
                colorButton.layer.borderWidth = 0.0
            }
        }
    }
}
