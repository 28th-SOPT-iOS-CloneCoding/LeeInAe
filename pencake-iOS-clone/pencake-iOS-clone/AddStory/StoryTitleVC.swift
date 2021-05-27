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

    override func viewDidLoad() {
        super.viewDidLoad()

        setView()
        setNavigation()
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
}
