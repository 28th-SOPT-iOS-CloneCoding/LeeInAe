//
//  NowReservationVC.swift
//  cgv-iOS-clone
//
//  Created by inae Lee on 2021/05/19.
//

import UIKit

class NowReservationVC: UIViewController {
    // MARK: - UIComponents

    private let popUpView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.cornerRound(radius: 18)
        view.clipsToBounds = true

        return view
    }()

    private let drawerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        view.cornerRound(radius: 3)

        return view
    }()

    private let headerView: UIView = {
        let view = UIView()
        view.setShadow(radius: 2, offset: .zero, opacity: 0.2)
        view.backgroundColor = UIColor.white
        view.layer.zPosition = 1

        return view
    }()

    private let closeButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "xmark"), for: .normal)
        btn.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(scale: .large), forImageIn: .normal)
        btn.tintColor = .black

        btn.addTarget(self, action: #selector(touchUpClose(_:)), for: .touchUpInside)

        return btn
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "지금예매"
        label.font = UIFont.AppleSDGothic(type: .semiBold, size: 18)

        return label
    }()

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.isScrollEnabled = false

        tableView.delegate = self
        tableView.dataSource = self

        return tableView
    }()

    private lazy var headerDateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.AppleSDGothic(type: .regular, size: 15)

        return label
    }()

    // MARK: - LifeCycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()

        /// 임시
        view.backgroundColor = UIColor(white: 0, alpha: 0.6)

        setConstraint()
    }
}

// MARK: - Actions

extension NowReservationVC {
    @objc func touchUpClose(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - Custom Methods

extension NowReservationVC {
    func setConstraint() {
        view.addSubviews([popUpView, drawerView])
        popUpView.addSubviews([headerView, tableView])
        headerView.addSubviews([closeButton, titleLabel])

        popUpView.snp.makeConstraints { make in
            make.leading.bottom.trailing.equalToSuperview()
            make.height.equalTo(500)
        }

        drawerView.snp.makeConstraints { make in
            make.bottom.equalTo(popUpView.snp.top).inset(-10)
            make.width.equalTo(60)
            make.height.equalTo(6)
            make.centerX.equalToSuperview()
        }

        headerView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(50)
        }

        tableView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }

        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }

        closeButton.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.trailing.equalToSuperview()
            make.width.height.equalTo(50)
        }
    }
}

// MARK: - UITableViewDelegate

extension NowReservationVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView()
        header.backgroundColor = UIColor.white

        let headerTitleLabel = UILabel()
        headerTitleLabel.font = UIFont.AppleSDGothic(type: .semiBold, size: 16)

        header.addSubviews([headerTitleLabel, headerDateLabel])

        headerTitleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
        }

        headerDateLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
        }

        if section == 0 {
            headerTitleLabel.text = "극장선택"
            headerDateLabel.isHidden = true
        }
        else {
            headerTitleLabel.text = "날짜/시간"
            headerDateLabel.text = "2021.5.20 (목) 오늘"
            headerDateLabel.isHidden = false
        }

        return header
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        48
    }
}

// MARK: - UITableViewDataSource

extension NowReservationVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        UITableViewCell()
    }
}
