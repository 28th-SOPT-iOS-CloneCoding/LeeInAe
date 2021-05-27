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

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        setNavigationBar()
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
    func setNavigationBar() {
        self.navigationItem.leftBarButtonItem = self.cancleButton
        self.navigationItem.rightBarButtonItem = self.completionButton
    }
}
