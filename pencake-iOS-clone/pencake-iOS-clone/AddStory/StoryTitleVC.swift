//
//  NewStoryVC.swift
//  pencake-iOS-clone
//
//  Created by inae Lee on 2021/05/27.
//

import UIKit

class StoryTitleVC: UIViewController {
    // MARK: - UIComponents

    private lazy var closeButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "닫기", style: .plain, target: self, action: #selector(touchUpCloseButton(_:)))
        button.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.NotoSerifKR(type: .regular, size: 17), NSAttributedString.Key.foregroundColor: UIColor.lightGray], for: .normal)

        return button
    }()

    private lazy var nextButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "다음", style: .plain, target: self, action: #selector(touchUpNextButton(_:)))
        button.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.NotoSerifKR(type: .regular, size: 17)], for: .normal)

        return button
    }()

    private lazy var titleTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "예) 곱창전골 먹고싶다 🥺"
        textField.font = UIFont.NotoSerifKR(type: .regular, size: 18)
        textField.textAlignment = .center
        textField.borderStyle = .none

        return textField
    }()

    private let guideLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.NotoSerifKR(type: .regular, size: 18)
        label.text = "새 이야기를 추가합니다.\n이야기의 제목을 입력해주세요"
        label.numberOfLines = 2
        label.sizeToFit()
        label.textAlignment = .center

        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setView()
        setNavigation()
        setConstraint()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        let border = CALayer()
        border.frame = CGRect(x: 0, y: self.titleTextField.frame.size.height - 1, width: self.titleTextField.frame.width, height: 1)
        border.backgroundColor = UIColor.systemGray4.cgColor
        self.titleTextField.layer.addSublayer(border)
    }
}

// MARK: - Action Methods

extension StoryTitleVC {
    @objc func touchUpCloseButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }

    @objc func touchUpNextButton(_ sender: UIBarButtonItem) {
        navigationController?.pushViewController(StorySubTitleVC(), animated: true)
    }
}

// MARK: - Custom Methods

extension StoryTitleVC {
    func setView() {
        view.backgroundColor = .white
    }

    func setNavigation() {
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.backgroundColor = .white
        self.navigationController?.navigationBar.shadowImage = UIImage()

        self.navigationItem.leftBarButtonItem = self.closeButton
        self.navigationItem.rightBarButtonItem = self.nextButton
    }

    func setConstraint() {
        view.addSubviews([self.guideLabel, self.titleTextField])

        self.guideLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-60)
        }

        self.titleTextField.snp.makeConstraints { make in
            make.top.equalTo(guideLabel.snp.bottom).offset(40)
            make.height.equalTo(guideLabel.bounds.height + 10)
            make.leading.trailing.equalToSuperview().inset(40)
        }
    }
}
