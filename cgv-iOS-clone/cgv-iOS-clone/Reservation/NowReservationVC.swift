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
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.white

        tableView.delegate = self
        tableView.dataSource = self

        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableView.automaticDimension

        tableView.register(TheaterTVC.self, forCellReuseIdentifier: TheaterTVC.identifier)
        tableView.register(DateTimeTVC.self, forCellReuseIdentifier: DateTimeTVC.identifier)

        return tableView
    }()

    private lazy var headerDateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.AppleSDGothic(type: .regular, size: 15)

        return label
    }()

    private let inquiryButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("조회하기", for: .normal)
        btn.titleLabel?.font = UIFont.AppleSDGothic(type: .bold, size: 18)
        btn.tintColor = UIColor.white
        btn.backgroundColor = UIColor.gray
        btn.cornerRound(radius: 13)

        return btn
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

        popUpView.addSubviews([headerView, tableView, inquiryButton])
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
            make.bottom.equalTo(inquiryButton.snp.top)
            make.leading.trailing.equalToSuperview()
        }

        inquiryButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(30)
            make.height.equalTo(55)
            make.leading.trailing.equalToSuperview().inset(20)
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
    // FIXME: - 코드 정리..
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView()
        header.backgroundColor = UIColor.white

        let headerTitleLabel = UILabel()
        headerTitleLabel.font = UIFont.AppleSDGothic(type: .semiBold, size: 16)

        header.addSubviews([headerTitleLabel])

        headerTitleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
        }

        if section == 0 {
            headerTitleLabel.text = "극장선택"
        }
        else {
            let separatorView = UIView()
            separatorView.backgroundColor = UIColor.systemGray4

            header.addSubviews([headerDateLabel, separatorView])

            separatorView.snp.makeConstraints { make in
                make.top.equalToSuperview()
                make.leading.trailing.equalToSuperview().inset(20)
                make.height.equalTo(1)
            }

            headerDateLabel.snp.makeConstraints { make in
                make.trailing.equalToSuperview().inset(20)
                make.centerY.equalToSuperview()
            }

            headerTitleLabel.text = "날짜/시간"
            headerDateLabel.text = "2021.5.20 (목) 오늘"
        }

        return header
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        50
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y < 0 {
            tableView.contentOffset.y = 0
        }
    }
}

// MARK: - UITableViewDataSource

extension NowReservationVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }

    // TODO: - : cell separator 없애기
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TheaterTVC.identifier) as? TheaterTVC else { return UITableViewCell() }

            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DateTimeTVC.identifier) as? DateTimeTVC else { return UITableViewCell() }
            
            return cell
        default:
            return UITableViewCell()
        }
    }
}
