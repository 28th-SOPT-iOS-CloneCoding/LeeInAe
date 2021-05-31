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
        
        return textview
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setView()
        setNavigationBar()
        setConstraint()
    }
}

// MARK: - Action Methods

extension WritingVC {
    @objc func touchUpCancleButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
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
    }

    func setConstraint() {
        view.addSubviews([self.titleTextField, self.contentTextView])

        self.titleTextField.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.height.equalTo(60)
            make.leading.trailing.equalToSuperview().inset(20)
        }

        self.contentTextView.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview()
        }
    }
}
