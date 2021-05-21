//
//  SubRegionCVC.swift
//  cgv-iOS-clone
//
//  Created by inae Lee on 2021/05/20.
//

import UIKit

class SubRegionCVC: UICollectionViewCell {
    static let identifier = "SubRegionCVC"

    // MARK: - UIComponents

    private let label: UILabel = {
        let label = UILabel()
        label.font = UIFont.AppleSDGothic(type: .semiBold, size: 18)
        label.textColor = UIColor.grayTextColor

        return label
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

    override func updateConstraints() {
        super.updateConstraints()
    }
}

// MARK: - Custom Methods

extension SubRegionCVC {
    func setCell(subRegion: String) {
        label.text = subRegion

        contentView.backgroundColor = UIColor.buttonBgGrayColor
        contentView.cornerRound(radius: 13)

        contentView.layer.borderWidth = 1.0
        contentView.layer.borderColor = UIColor.systemGray4.cgColor
    }

    func setConstraint() {
        contentView.addSubviews([label])

        label.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
}
