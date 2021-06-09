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

    private lazy var subTitleTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "예) 내일도 먹어야지!"
        textField.font = UIFont.NotoSerifKR(type: .regular, size: 18)
        textField.textAlignment = .center
        textField.borderStyle = .none

        return textField
    }()

    private let guideLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.NotoSerifKR(type: .regular, size: 18)
        label.text = "이야기의 소제목을 입력해주세요.\n다짐말을 써도 좋아요."
        label.numberOfLines = 2
        label.sizeToFit()
        label.textAlignment = .center

        return label
    }()

    // MARK: - local variables

    let labelTopAnchor: CGFloat = -120

    var storyTitle: String?

    // MARK: - LifeCycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()

        setView()
        setNavigationBar()
        setNotification()
        setConstraint()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        /// textfield border
        let border = CALayer()
        border.frame = CGRect(x: 0, y: self.subTitleTextField.frame.size.height - 1, width: self.subTitleTextField.frame.width, height: 1)
        border.backgroundColor = UIColor.systemGray4.cgColor
        self.subTitleTextField.layer.addSublayer(border)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

// MARK: - Action Methods

extension StorySubTitleVC {
    @objc func touchUpCompletionButton(_ sender: UIBarButtonItem) {
        guard let title = subTitleTextField.text else { return }

        if title.isEmpty {
            let alert = UIAlertController(title: nil, message: "소제목을 입력해주세요", preferredStyle: .alert)
            let submitAction = UIAlertAction(title: "확인", style: .default, handler: nil)
            alert.addAction(submitAction)

            self.present(alert, animated: true, completion: nil)
        } else {
            saveNewStory()
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

extension StorySubTitleVC {
    func setView() {
        view.backgroundColor = .white

        self.subTitleTextField.becomeFirstResponder()
    }

    func setNavigationBar() {
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.shadowImage = UIImage()

        navigationItem.rightBarButtonItem = self.completionButton
        navigationItem.backBarButtonItem?.tintColor = .lightGray
        navigationController?.navigationBar.topItem?.title = ""
    }

    func setConstraint() {
        view.addSubviews([self.guideLabel, self.subTitleTextField])

        self.guideLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(labelTopAnchor)
        }

        self.subTitleTextField.snp.makeConstraints { make in
            make.top.equalTo(guideLabel.snp.bottom).offset(40)
            make.height.equalTo(guideLabel.bounds.height + 10)
            make.leading.trailing.equalToSuperview().inset(40)
        }
    }

    func setNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.willShowKeyboard(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.willHideKeyboard(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    func saveNewStory() {
        let newStory = Story()

        if let title = storyTitle,
           let subTitle = subTitleTextField.text
        {
            newStory.title = title
            newStory.subTitle = subTitle
            newStory.index = Database.shared.getTotalCount(model: Story.self) + 1
        }

        Database.shared.saveModelData(model: newStory) { result in
            if result {
                /// local 저장
                let newStoryVC = StoryVC(viewModel: StoryViewModel())
                ContainerVC.pages.append(newStoryVC)

                NotificationCenter.default.post(name: Notification.Name.didSavedNewStory, object: newStoryVC)

                Database.shared.updateStories()
                self.dismiss(animated: true, completion: nil)
            } else {
                self.sorryAlert(message: "저장에.. 실패했습니다")
            }
        }
    }
}
