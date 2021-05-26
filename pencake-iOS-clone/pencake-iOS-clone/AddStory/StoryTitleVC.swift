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
    }
}
