//
//  StorySubTitleVC.swift
//  pencake-iOS-clone
//
//  Created by inae Lee on 2021/05/27.
//

import UIKit

class StorySubTitleVC: UIViewController {
    // MARK: - UIComponents

    private lazy var completionButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(touchUpCompletionButton(_:)))

        return button
    }()

    // MARK: - LifeCycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()

        setNavigationBar()
    }
}

// MARK: - Action Methods

extension StorySubTitleVC {
    @objc func touchUpCompletionButton(_ sender: UIBarButtonItem) {
        ContainerVC.pages.insert(StoryVC(), at: 0)

        self.dismiss(animated: true, completion: nil)
    }
}

// MARK: - Custom Methods

extension StorySubTitleVC {
    func setNavigationBar() {
        self.navigationItem.rightBarButtonItem = self.completionButton
    }
}
