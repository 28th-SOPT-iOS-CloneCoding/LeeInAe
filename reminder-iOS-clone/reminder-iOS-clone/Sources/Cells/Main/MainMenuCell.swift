//
//  MainMenuCell.swift
//  reminder-iOS-clone
//
//  Created by inae Lee on 2021/04/15.
//

import UIKit

class MainMenuCell: UICollectionViewCell {
    @IBOutlet var label: UILabel!

    func setLabel(idx: Int) {
        backgroundColor = UIColor.gray
        label.text = "index \(idx)"
    }

    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        setNeedsLayout()
        layoutIfNeeded()

        let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
        let frame = layoutAttributes.frame

        self.frame.size.width = size.width
        layoutAttributes.frame = frame
        return layoutAttributes
    }
}
