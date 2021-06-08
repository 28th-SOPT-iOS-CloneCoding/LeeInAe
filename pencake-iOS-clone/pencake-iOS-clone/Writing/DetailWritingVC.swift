//
//  DetailWritingVC.swift
//  pencake-iOS-clone
//
//  Created by inae Lee on 2021/06/07.
//

import UIKit

class DetailWritingVC: UIViewController {
    // MARK: - UIComponents

    private var navigationView: UIView = {
        let view = UIView(frame: CGRect(origin: .zero, size: CGSize(width: UIScreen.main.bounds.width, height: 44)))
        view.backgroundColor = .white

        return view
    }()

    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        button.tintColor = .lightGray
        button.addTarget(self, action: #selector(touchUpBackButton(_:)), for: .touchUpInside)

        return button
    }()

    private var separator: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray

        return view
    }()

    private var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "안녕하세요"
        label.font = UIFont.NotoSerifKR(type: .bold, size: 18)

        return label
    }()

    private var dateLabel: UILabel = {
        let label = UILabel()
        label.text = Date().getDateToString(date: Date())
        label.font = UIFont.NotoSerifKR(type: .regular, size: 13)
        label.textColor = UIColor.lightGray

        return label
    }()

    private var contentLabel: UILabel = {
        let label = UILabel()
        label.text = "에스파는 나야 둘이 될 수 없어"
        label.font = UIFont.NotoSerifKR(type: .regular, size: 15)

        return label
    }()

    // MARK: - LifeCycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()

        setConstraint()
        setNavigationBar()
    }
}

// MARK: - Action

extension DetailWritingVC {
    @objc func touchUpBackButton(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - Custom Method

extension DetailWritingVC {
    func setConstraint() {
        view.addSubviews([navigationView, backButton, separator, titleLabel, dateLabel, contentLabel])
        navigationView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(44)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(48)
        }

        backButton.snp.makeConstraints { make in
            make.leading.equalTo(navigationView.snp.leading)
            make.centerY.equalTo(navigationView.snp.centerY)
            make.width.height.equalTo(navigationView.snp.height)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(navigationView).offset(60)
            make.leading.trailing.equalToSuperview().inset(40)
        }

        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
            make.leading.equalTo(titleLabel.snp.leading)
            make.trailing.equalTo(titleLabel.snp.trailing)
        }

        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(40)
            make.leading.equalTo(titleLabel.snp.leading)
            make.trailing.equalTo(titleLabel.snp.trailing)
        }
    }

    func setNavigationBar() {
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
    }
}
