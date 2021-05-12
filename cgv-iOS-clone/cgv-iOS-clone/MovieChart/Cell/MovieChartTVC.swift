//
//  MovieChartTVC.swift
//  cgv-iOS-clone
//
//  Created by inae Lee on 2021/05/11.
//

import Kingfisher
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
        label.font = UIFont.AppleSDGothic(type: .bold, size: 14)
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail

        return label
    }()

    private let releaseDateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.AppleSDGothic(type: .light, size: 11)

        return label
    }()

    private let popularityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.AppleSDGothic(type: .semiBold, size: 12)
        label.textColor = UIColor.adultColor

        return label
    }()

    private let voteLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.AppleSDGothic(type: .regular, size: 11)
        label.textColor = UIColor.lightGray

        return label
    }()

    private let reservationButton: UIButton = {
        let button = UIButton()
        button.setTitle("지금 예매", for: .normal)
        button.titleLabel?.font = UIFont.AppleSDGothic(type: .bold, size: 11)
        button.tintColor = .white
        button.backgroundColor = UIColor(red: 185/255, green: 51/255, blue: 49/255, alpha: 1)

        return button
    }()

    private let screenGradeButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.allAgeColor
        button.titleLabel?.font = UIFont.AppleSDGothic(type: .semiBold, size: 9)
        button.titleLabel?.textAlignment = .center

        return button
    }()

    // MARK: - local Variables

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
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    override func updateConstraints() {
        layoutIfNeeded()

        screenGradeButton.cornerRounds()
        reservationButton.cornerRound(radius: 3)

        super.updateConstraints()
    }

    // MARK: - Custom Methods

    func setValue(title: String, poster: String, release: String, isAdult: Bool, popularity: Double, voteCount: Int, voteAvg: Double) {
        titleLabel.text = title
        posterImage.kf.setImage(with: URL(string: MovieService.imageBaseURL + poster))
        screenGradeButton.backgroundColor = isAdult ? UIColor.adultColor : UIColor.allAgeColor
        screenGradeButton.setTitle(isAdult ? "청불" : "전체", for: .normal)
        popularityLabel.text = "인기도 \(String().commaToNumbers(num: Int(popularity)))"
        voteLabel.text = "투표율 \(String().commaToNumbers(num: Int(voteCount))) • 투표 평균 \(String().commaToNumbers(num: Int(voteAvg)))"

        /// fomatt release date
        let date = Date().getStringToDate(date: release)
        let newDate = Date().getDateToString(date: date)
        releaseDateLabel.text = "\(newDate) 개봉"

        /// change popularityLabel color
        let attributedStr = NSMutableAttributedString(string: popularityLabel.text!)

        attributedStr.addAttribute(.foregroundColor, value: UIColor.black, range: (popularityLabel.text! as NSString).range(of: "인기도"))
        popularityLabel.attributedText = attributedStr
    }

    func setConstraints() {
        contentView.addSubviews([posterImage, titleLabel, screenGradeButton, popularityLabel, releaseDateLabel, reservationButton, voteLabel])

        // FIXME: - height Constraint log 없애고 싶음..
        posterImage.snp.makeConstraints { make in
            make.width.equalTo(90)
            make.height.equalTo(120)
            make.top.equalTo(contentView.snp.top).inset(10)
            make.leading.equalTo(contentView.snp.leading).inset(10)
            make.bottom.equalTo(contentView.snp.bottom).inset(10)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(posterImage.snp.top).inset(8)
            make.leading.equalTo(posterImage.snp.trailing).inset(-10)
        }

        screenGradeButton.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel.snp.trailing).inset(-5)
            make.trailing.lessThanOrEqualToSuperview().inset(10)
            make.height.width.equalTo(18)
            make.centerY.equalTo(titleLabel.snp.centerY)
        }

        popularityLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).inset(-5)
            make.leading.equalTo(titleLabel.snp.leading)
        }

        releaseDateLabel.snp.makeConstraints { make in
            make.top.equalTo(popularityLabel.snp.bottom).inset(-3)
            make.leading.equalTo(titleLabel.snp.leading)
        }

        voteLabel.snp.makeConstraints { make in
            make.top.equalTo(releaseDateLabel.snp.bottom).inset(-3)
            make.leading.equalTo(titleLabel.snp.leading)
        }

        reservationButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(10)
            make.width.equalTo(50)
            make.bottom.equalTo(posterImage.snp.bottom)
        }
    }
}
