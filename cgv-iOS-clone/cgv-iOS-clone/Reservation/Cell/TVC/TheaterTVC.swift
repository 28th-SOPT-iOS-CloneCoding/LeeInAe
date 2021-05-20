//
//  TheaterTableVIewCell.swift
//  cgv-iOS-clone
//
//  Created by inae Lee on 2021/05/20.
//

import UIKit

class TheaterTVC: UITableViewCell {
    static let identifier = "TheaterTVC"

    // MARK: - UIComponents

    let regionCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal

        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .white

        return collection
    }()

    let subRegionCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal

        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .white

        return collection
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
}

// MARK: - Custom Methods

extension TheaterTVC {
    func setConstraint() {
        contentView.addSubviews([regionCollectionView, subRegionCollectionView])

        regionCollectionView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.edges.equalToSuperview()
        }

        subRegionCollectionView.snp.makeConstraints { make in
            make.top.equalTo(regionCollectionView.snp.bottom)
            make.leading.bottom.trailing.equalToSuperview()
        }
    }

    func setCollectionView() {
        /// data
        Theater.theater.selectedIdx = 0

        regionCollectionView.delegate = self
        regionCollectionView.dataSource = self
        regionCollectionView.register(RegionCVC.self, forCellWithReuseIdentifier: RegionCVC.identifier)

        subRegionCollectionView.delegate = self
        subRegionCollectionView.dataSource = self
        subRegionCollectionView.register(SubRegionCVC.self, forCellWithReuseIdentifier: SubRegionCVC.identifier)
    }
}

// MARK: - UICollectionViewDataSource

extension TheaterTVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == regionCollectionView {
            return Theater.theater.regionArr.count
        }
        return Theater.theater.subRegionArr.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == regionCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RegionCVC.identifier, for: indexPath) as? RegionCVC else { return UICollectionViewCell() }
            cell.setCell(region: Theater.theater.regionArr[indexPath.row])

            return cell

        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SubRegionCVC.identifier, for: indexPath) as? SubRegionCVC else { return UICollectionViewCell() }
            cell.backgroundColor = .blue

            return cell
        }
    }
}

// MARK: - UICollectionView

extension TheaterTVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let label = UILabel()
        var width = CGFloat()
        var height = CGFloat()

        if collectionView == regionCollectionView {
            label.text = Theater.theater.regionArr[indexPath.row]
            label.sizeToFit()

            width = label.bounds.size.width + 12
            height = 20
            return CGSize(width: width, height: height)
        }

        return CGSize()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        10
//    }
//
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        5
    }
}
