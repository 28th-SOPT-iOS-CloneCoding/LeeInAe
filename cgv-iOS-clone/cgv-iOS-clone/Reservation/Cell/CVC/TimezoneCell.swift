//
//  TimezoneCell.swift
//  cgv-iOS-clone
//
//  Created by inae Lee on 2021/05/23.
//

import UIKit

class TimezoneCell: UICollectionViewCell {
    static let identifier = "TimezoneCell"

    // MARK: - UIComponents

    private let label: UILabel = {
        let label = UILabel()
        label.font = UIFont.AppleSDGothic(type: .semiBold, size: 15)
        label.textColor = UIColor.grayTextColor

        return label
    }()

    override var isSelected: Bool {
        didSet {
            if isSelected {
                label.textColor = UIColor.mainRedColor

                contentView.layer.borderColor = UIColor.mainRedColor.cgColor
                contentView.backgroundColor = .white
                contentView.layer.borderColor = UIColor.mainRedColor.cgColor

                layer.shadowOpacity = 0.3

            } else {
                label.textColor = UIColor.grayTextColor

                contentView.layer.borderColor = UIColor.mainRedColor.cgColor
                contentView.backgroundColor = .buttonBgGrayColor
                contentView.layer.borderColor = UIColor.systemGray4.cgColor

                layer.shadowOpacity = 0
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

    override func updateConstraints() {
        super.updateConstraints()
    }
}

// MARK: - Custom Methods

extension TimezoneCell {
    func setCell(time: String) {
        label.text = time
        label.sizeToFit()

        contentView.backgroundColor = UIColor.buttonBgGrayColor
        contentView.cornerRound(radius: 13)

        contentView.layer.borderWidth = 1.0
        contentView.layer.borderColor = UIColor.systemGray4.cgColor

        setShadow(radius: 3, offset: CGSize(width: 1, height: 3), opacity: 0, color: .mainRedColor)
    }

    func setConstraint() {
        contentView.addSubviews([label])

        label.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
}
