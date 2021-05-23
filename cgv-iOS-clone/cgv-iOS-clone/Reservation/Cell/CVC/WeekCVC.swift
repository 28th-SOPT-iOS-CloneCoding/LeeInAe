//
//  WeekCVC.swift
//  cgv-iOS-clone
//
//  Created by inae Lee on 2021/05/23.
//

import UIKit

class WeekCVC: UICollectionViewCell {
    static let identifier = "WeekCVC"

    // MARK: - UIComponents

    private let dateView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.cornerRound(radius: 13)
        view.layer.borderColor = UIColor.mainRedColor.cgColor
        view.setShadow(radius: 3, offset: CGSize(width: 1, height: 3), opacity: 0, color: .mainRedColor)

        return view
    }()

    private let dayLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.AppleSDGothic(type: .bold, size: 18)
        label.textColor = UIColor.grayTextColor
        label.text = "23"

        return label
    }()

    private let dayOfWeekLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.AppleSDGothic(type: .semiBold, size: 12)
        label.textColor = UIColor.grayTextColor
        label.text = "월"

        return label
    }()

    override var isSelected: Bool {
        didSet {
            if isSelected {
                dayLabel.textColor = UIColor.mainRedColor
                dayOfWeekLabel.textColor = UIColor.mainRedColor

                dateView.layer.shadowOpacity = 0.3
                dateView.layer.borderWidth = 1.0

            } else {
                dayLabel.textColor = UIColor.grayTextColor
                dayOfWeekLabel.textColor = UIColor.grayTextColor

                dateView.layer.borderColor = UIColor.mainRedColor.cgColor
                dateView.layer.borderWidth = 0.0

                dateView.layer.shadowOpacity = 0
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

extension WeekCVC {
    func setConstraint() {
        contentView.addSubviews([dateView, dayOfWeekLabel])
        dateView.addSubview(dayLabel)

        dateView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(contentView.snp.width).multipliedBy(0.8)
        }

        dayOfWeekLabel.snp.makeConstraints { make in
            make.top.equalTo(dateView.snp.bottom).inset(-8)
            make.centerX.equalToSuperview()
        }

        dayLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }

    func setCell(date: Date) {
        print(date.getDateToString(date: date))
        dayLabel.text = date.getDateToString(format: "d", date: date)
        dayOfWeekLabel.text = date.getDateToString(format: "EEEEE", date: date)
    }
}
