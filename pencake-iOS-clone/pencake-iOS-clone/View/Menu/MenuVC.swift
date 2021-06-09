//
//  MenuVC.swift
//  pencake-iOS-clone
//
//  Created by inae Lee on 2021/06/09.
//

import UIKit

class MenuVC: UIViewController {
    // MARK: - UIComponents

    private lazy var deleteStoryButton: UIButton = {
        let button = UIButton()
        button.setTitle("이야기 제거", for: .normal)
        button.titleLabel?.font = UIFont.NotoSerifKR(type: .regular, size: 20)
        button.setTitleColor(UIColor.systemPink, for: .normal)

        return button
    }()

    private lazy var addStoryButton: UIButton = {
        let button = UIButton()
        button.setTitle("이야기 추가", for: .normal)
        button.titleLabel?.font = UIFont.NotoSerifKR(type: .regular, size: 20)
        button.setTitleColor(UIColor.black, for: .normal)
        button.isHidden = true
        button.addTarget(self, action: #selector(touchUpAddStoryButton(_:)), for: .touchUpInside)

        return button
    }()

    private lazy var addWritingButton: UIButton = {
        let button = UIButton()
        button.setTitle("글 추가", for: .normal)
        button.titleLabel?.font = UIFont.NotoSerifKR(type: .regular, size: 20)
        button.setTitleColor(UIColor.black, for: .normal)

        return button
    }()

    private lazy var closeButton: UIButton = {
        let button = UIButton(frame: CGRect(origin: .zero, size: CGSize(width: 60, height: 60)))
        button.addTarget(self, action: #selector(touchUpCloseButton(_:)), for: .touchUpInside)
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(scale: .large), forImageIn: .normal)
        button.tintColor = UIColor.lightGray
        button.backgroundColor = .white

        return button
    }()

    // MARK: - LifeCycle Methods

    override func viewWillAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.3) {
            self.closeButton.transform = CGAffineTransform(rotationAngle: .pi / 4)
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        UIView.animate(withDuration: 0.3) {
            self.closeButton.transform = CGAffineTransform(rotationAngle: -.pi / 4)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setView()
        setConstraint()
    }
}

private extension MenuVC {
    func setConstraint() {
        view.addSubviews([deleteStoryButton, addWritingButton, closeButton, addStoryButton])

        deleteStoryButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(250)
            make.centerX.equalToSuperview()
        }

        addWritingButton.snp.makeConstraints { make in
            make.top.equalTo(deleteStoryButton.snp.bottom).offset(60)
            make.centerX.equalToSuperview()
        }

        addStoryButton.snp.makeConstraints { make in
            make.top.equalTo(addWritingButton.snp.bottom).offset(60)
            make.centerX.equalToSuperview()
        }

        closeButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-40)
            make.width.height.equalTo(60)
        }
    }

    func setView() {
        view.backgroundColor = .white

        if ContainerVC.currPage == 0 {
            addStoryButton.isHidden = false
        }
    }
}

extension MenuVC {
    @objc func touchUpCloseButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

    @objc func touchUpAddStoryButton(_ sender: UIButton) {
        let storyTitleVC = StoryTitleVC()
        let navigationController = UINavigationController(rootViewController: storyTitleVC)

        navigationController.modalPresentationStyle = .overCurrentContext

        present(navigationController, animated: true, completion: nil)
    }
}
