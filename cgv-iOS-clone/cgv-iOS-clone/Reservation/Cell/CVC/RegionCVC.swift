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

    let button: UIButton = {
        let btn = UIButton()
        btn.titleLabel?.font = UIFont.AppleSDGothic(type: .semiBold, size: 15)
        btn.setTitleColor(UIColor.grayTextColor, for: .normal)
        btn.setTitleColor(UIColor.adultColor, for: .selected)
        
        btn.sizeToFit()

        return btn
    }()

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
        button.setTitle(region, for: .normal)
    }

    func setConstraint() {
        contentView.addSubviews([button])

        button.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
}
