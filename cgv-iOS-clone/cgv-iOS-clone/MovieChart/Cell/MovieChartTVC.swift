//
//  MovieChartTVC.swift
//  cgv-iOS-clone
//
//  Created by inae Lee on 2021/05/11.
//

import SnapKit
import UIKit

class MovieChartTVC: UITableViewCell {
    static let identifier = "MovieChartTVC"

    // MARK: - IBOutlets

    private lazy var posterImage: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage()
        imageView.image = image

        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.AppleSDGothic(type: .semiBold, size: 15)
        label.numberOfLines = 0

        return label
    }()

    private let releaseDateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.AppleSDGothic(type: .light, size: 13)

        return label
    }()

    private let reservationButton: UIButton = {
        let button = UIButton()
        button.setTitle("지금 예매", for: .normal)
        button.tintColor = .white
        button.cornerRound(radius: 10)
        button.backgroundColor = UIColor(red: 185/255, green: 51/255, blue: 49/255, alpha: 1)

        return button
    }()

    private let screenGradeButton: UIButton = {
        let button = UIButton()
        button.cornerRounds()
        button.backgroundColor = UIColor.allAgeColor
        button.titleLabel?.font = UIFont.AppleSDGothic(type: .semiBold, size: 9)

        return button
    }()

    // MARK: - local Variables

    private var titleName: String?
    private var posterPath: String?
    private var releaseDate: String?
    private var isAdult: Bool?

    // MARK: - Initializer

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setConstraints()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - LifeCycle

    override func awakeFromNib() {
        super.awakeFromNib()
//        setConstraints()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    // MARK: - Custom Methods

    func setValue(title: String, poster: String, release: String, isAdult: Bool) {
        titleLabel.text = title
        posterImage.image = UIImage(systemName: "bookmark")
        releaseDateLabel.text = release
        screenGradeButton.backgroundColor = isAdult ? UIColor.adultColor : UIColor.allAgeColor
        screenGradeButton.setTitle(isAdult ? "all" : "청불", for: .normal)
    }

    func setConstraints() {
        contentView.addSubviews([posterImage, titleLabel, screenGradeButton])
        posterImage.snp.makeConstraints { make in
            make.width.equalTo(90)
            make.height.equalTo(120)
            make.top.leading.bottom.equalToSuperview().inset(10)
            make.centerY.equalToSuperview()
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(posterImage.snp.top).inset(13)
            make.leading.equalTo(posterImage.snp.trailing).inset(-10)
        }

        screenGradeButton.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.top)
            make.leading.equalTo(titleLabel.snp.trailing).inset(-10)
            make.bottom.equalTo(titleLabel.snp.bottom)
            make.width.equalTo(self.bounds.height)
        }
    }
}
