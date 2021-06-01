//
//  WritingVC.swift
//  pencake-iOS-clone
//
//  Created by inae Lee on 2021/05/28.
//

import UIKit

class WritingVC: UIViewController {
    // MARK: - UIComponents

    private lazy var cancleButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(touchUpCancleButton(_:)))
        button.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.NotoSerifKR(type: .regular, size: 17), NSAttributedString.Key.foregroundColor: UIColor.lightGray], for: .normal)

        return button
    }()

    private lazy var completionButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(touchUpCancleButton(_:)))
        button.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.NotoSerifKR(type: .regular, size: 17)], for: .normal)

        return button
    }()

    private let titleTextField: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "제목"
        textfield.font = UIFont.NotoSerifKR(type: .semiBold, size: 20)

        return textfield
    }()

    private let contentTextView: UITextView = {
        let textview = UITextView()
        textview.font = UIFont.NotoSerifKR(type: .regular, size: 15)

        return textview
    }()

    private lazy var naviTitleButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.NotoSerifKR(type: .regular, size: 17)
        button.addTarget(self, action: #selector(touchUpNavigation(_:)), for: .touchUpInside)

        return button
    }()

    private let separator: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.systemGray5

        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setView()
        setTextField()
        setNavigationBar()
        setConstraint()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.titleTextField.endEditing(true)
    }
}

// MARK: - Action Methods

extension WritingVC {
    @objc func touchUpCancleButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }

    @objc func touchUpNavigation(_ sender: UIButton) {
        print("네비")
        deRegisterNavigationTitleButton()
    }
}

// MARK: - Custom Methods

extension WritingVC {
    func setView() {
        view.backgroundColor = .white
    }

    func setNavigationBar() {
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = .white
        self.navigationController?.navigationBar.shadowImage = UIImage()

        self.navigationItem.leftBarButtonItem = self.cancleButton
        self.navigationItem.rightBarButtonItem = self.completionButton

        self.navigationItem.titleView = .none
        self.navigationItem.titleView?.alpha = 0
    }

    func setConstraint() {
        view.addSubviews([self.titleTextField, self.contentTextView, self.separator])

        self.titleTextField.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.height.equalTo(60)
            make.leading.trailing.equalToSuperview().inset(20)
        }

        self.contentTextView.snp.makeConstraints { make in
            make.top.equalTo(separator.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview()
        }

        self.separator.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(1)
        }
    }

    func setTextField() {
        self.titleTextField.delegate = self
        self.titleTextField.becomeFirstResponder()
    }

    func registerNavigationTitleButton() {
        guard let title = self.titleTextField.text else { return }
        self.naviTitleButton.setTitle(title, for: .normal)

        UIView.animate(withDuration: 0.4) {
            self.navigationItem.titleView = self.naviTitleButton
            self.navigationItem.titleView?.alpha = 1

            self.titleTextField.snp.updateConstraints { make in
                make.height.equalTo(0)
            }
        }
    }

    func deRegisterNavigationTitleButton() {
        UIView.animate(withDuration: 0.4) {
            self.navigationItem.titleView?.alpha = 0

            self.titleTextField.snp.updateConstraints { make in
                make.height.equalTo(60)
            }
        } completion: { _ in
            self.navigationItem.titleView = .none
            self.titleTextField.becomeFirstResponder()
        }
    }
}

extension WritingVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.registerNavigationTitleButton()
        self.titleTextField.resignFirstResponder()

        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        self.titleTextField.resignFirstResponder()
        self.registerNavigationTitleButton()
    }
}
