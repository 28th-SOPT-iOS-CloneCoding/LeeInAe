//
//  RegionCVC.swift
//  cgv-iOS-clone
//
//  Created by inae Lee on 2021/05/20.
//

import UIKit

class RegionCVC: UICollectionViewCell {
    static let identifier = "RegionCVC"

    // MARK: - UIComponents

    let label: UILabel = {
        let label = UILabel()
        label.font = UIFont.AppleSDGothic(type: .semiBold, size: 16)
        label.textColor = UIColor.grayTextColor

        return label
    }()
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                label.textColor = UIColor.mainRedColor
            } else {
                label.textColor = UIColor.grayTextColor
            }
        }
    }

    // MARK: - Initializer

    override init(frame: CGRect) {
        super.init(frame: frame)

        setConstraint()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Custom Methods

extension RegionCVC {
    func setCell(region: String) {
        label.text = region
        label.sizeToFit()
    }

    func setConstraint() {
        contentView.addSubviews([label])

        label.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
}
