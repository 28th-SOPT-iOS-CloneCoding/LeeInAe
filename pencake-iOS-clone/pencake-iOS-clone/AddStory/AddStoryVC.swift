//
//  AddStoryVC.swift
//  pencake-iOS-clone
//
//  Created by inae Lee on 2021/05/26.
//

import UIKit

class AddStoryVC: UIViewController {
    // MARK: - UIComponents

    private let plusButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "plus"), for: .normal)
        btn.tintColor = UIColor.lightGray
        btn.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 100, weight: .light), forImageIn: .normal)

        btn.addTarget(self, action: #selector(touchUpPlus(_:)), for: .touchUpInside)

        return btn
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.NotoSerifKR(type: .light, size: 13)
        label.textColor = UIColor.lightGray
        label.text = "+를 눌러서 새 이야기를 시작하세요"

        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setView()
        setConstraint()
    }
}

// MARK: -  Custom Methods

extension AddStoryVC {
    func setView() {
        view.backgroundColor = .white
    }

    func setConstraint() {
        view.addSubviews([plusButton, descriptionLabel])

        plusButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-30)
        }

        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(plusButton.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
        }
    }
}

// MARK: - action Methods

extension AddStoryVC {
    @objc func touchUpPlus(_ sender: UIButton) {
        let storyTitleVC = StoryTitleVC()
        let navigationController = UINavigationController(rootViewController: storyTitleVC)

        navigationController.modalPresentationStyle = .fullScreen

        present(navigationController, animated: true, completion: nil)
    }
}
