//
//  DateTimeTVC.swift
//  cgv-iOS-clone
//
//  Created by inae Lee on 2021/05/23.
//

import UIKit

class DateTimeTVC: UITableViewCell {
    static let identifier = "DateTimeTVC"

    // MARK: - UIComponents

    let weekCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal

        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .white

        return collection
    }()

    let timezoneCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal

        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .white

        return collection
    }()

    // MARK: - Local variables

    var dates: [Date] = {
        var dates: [Date] = []
        for t in 0 ..< 14 {
            dates.append(Date(timeIntervalSinceNow: TimeInterval(86400 * t)))
        }

        return dates
    }()

    // MARK: - Initializer

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setConstraint()
        setCollectionView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func updateConstraints() {
        print("updateConstraint")

        super.updateConstraints()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    // MARK: - Action Methods
}

// MARK: - Custom Methods

extension DateTimeTVC {
    func setConstraint() {
        contentView.addSubviews([weekCollectionView, timezoneCollectionView])

        weekCollectionView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(80)
        }

        timezoneCollectionView.snp.makeConstraints { make in
            make.top.equalTo(weekCollectionView.snp.bottom)
            make.leading.bottom.trailing.equalToSuperview()
            make.height.equalTo(50)
        }
    }

    func setCollectionView() {
        weekCollectionView.delegate = self
        weekCollectionView.dataSource = self
        weekCollectionView.register(WeekCVC.self, forCellWithReuseIdentifier: WeekCVC.identifier)

        timezoneCollectionView.delegate = self
        timezoneCollectionView.dataSource = self
        timezoneCollectionView.register(WeekCVC.self, forCellWithReuseIdentifier: WeekCVC.identifier)
    }
}

extension DateTimeTVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 18, bottom: 0, right: 0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 55, height: 100)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .init())
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        
        NotificationCenter.default.post(name: Notification.Name.touchUpWeekCell, object: dates[indexPath.row])
    }
}

extension DateTimeTVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == weekCollectionView {
            return 14
        }
        return 4
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeekCVC.identifier, for: indexPath) as? WeekCVC else { return UICollectionViewCell() }
        cell.setCell(date: dates[indexPath.row], idx: indexPath.row)

        if indexPath.item == 0 {
            cell.isSelected = true
            collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .init())
        }

        return cell
    }
}
