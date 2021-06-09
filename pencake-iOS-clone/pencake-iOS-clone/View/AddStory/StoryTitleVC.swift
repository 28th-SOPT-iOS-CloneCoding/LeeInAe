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

    // MARK: - local variables

    let labelTopAnchor: CGFloat = -120

    override func viewDidLoad() {
        super.viewDidLoad()

        setView()
        setNavigation()
        setConstraint()
        setNotification()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        /// textfield border
        let border = CALayer()
        border.frame = CGRect(x: 0, y: self.titleTextField.frame.size.height - 1, width: self.titleTextField.frame.width, height: 1)
        border.backgroundColor = UIColor.systemGray4.cgColor
        self.titleTextField.layer.addSublayer(border)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

// MARK: - Action Methods

extension StoryTitleVC {
    @objc func touchUpCloseButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }

    @objc func touchUpNextButton(_ sender: UIBarButtonItem) {
        guard let title = titleTextField.text else { return }

        if title.isEmpty {
            let alert = UIAlertController(title: nil, message: "제목을 입력해주세요", preferredStyle: .alert)
            let submitAction = UIAlertAction(title: "확인", style: .default, handler: nil)
            alert.addAction(submitAction)

            self.present(alert, animated: true, completion: nil)
        } else {
            let subTitleVC = StorySubTitleVC()
            subTitleVC.storyTitle = title

            navigationController?.pushViewController(subTitleVC, animated: true)
        }
    }
    
    @objc func willShowKeyboard(_ noti: Notification) {
        let topAnchor = self.labelTopAnchor - 40

        self.guideLabel.snp.updateConstraints { make in
            make.centerY.equalToSuperview().offset(topAnchor)
        }

        UIView.animate(withDuration: 0.8) {
            self.view.layoutIfNeeded()
        }
    }

    @objc func willHideKeyboard(_ noti: Notification) {
        let topAnchor = self.labelTopAnchor + 40

        self.guideLabel.snp.updateConstraints { make in
            make.centerY.equalToSuperview().offset(topAnchor)
        }

        UIView.animate(withDuration: 0.8) {
            self.view.layoutIfNeeded()
        }
    }
}

// MARK: - Custom Methods

extension StoryTitleVC {
    func setView() {
        view.backgroundColor = .white

        self.titleTextField.becomeFirstResponder()
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
            make.centerY.equalToSuperview().offset(labelTopAnchor)
        }

        self.titleTextField.snp.makeConstraints { make in
            make.top.equalTo(guideLabel.snp.bottom).offset(40)
            make.height.equalTo(guideLabel.bounds.height + 10)
            make.leading.trailing.equalToSuperview().inset(40)
        }
    }

    func setNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.willShowKeyboard(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(self.willHideKeyboard(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}
