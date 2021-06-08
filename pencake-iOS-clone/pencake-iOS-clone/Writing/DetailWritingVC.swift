//
//  DetailWritingVC.swift
//  pencake-iOS-clone
//
//  Created by inae Lee on 2021/06/07.
//

import UIKit

class DetailWritingVC: UIViewController {
    // MARK: - UIComponents

    private var navigationView: UIView = {
        let view = UIView(frame: CGRect(origin: .zero, size: CGSize(width: UIScreen.main.bounds.width, height: 44)))
        view.backgroundColor = .white

        return view
    }()

    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        button.tintColor = .lightGray
        button.addTarget(self, action: #selector(touchUpBackButton(_:)), for: .touchUpInside)

        return button
    }()

    private lazy var moreButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        button.tintColor = .lightGray
        button.addTarget(self, action: #selector(touchUpMoreButton(_:)), for: .touchUpInside)

        return button
    }()

    private var separator: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.systemGray4

        return view
    }()

    private var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "안녕하세요"
        label.font = UIFont.NotoSerifKR(type: .bold, size: 18)

        return label
    }()

    private var dateLabel: UILabel = {
        let label = UILabel()
        label.text = Date().getDateToString(date: Date())
        label.font = UIFont.NotoSerifKR(type: .regular, size: 15)
        label.textColor = UIColor.lightGray

        return label
    }()

    private var contentLabel: UILabel = {
        let label = UILabel()
        label.text = "에스파는 나야 둘이 될 수 없어 Naevis. calling. ae..spa? ae.. inae..?"
        label.font = UIFont.NotoSerifKR(type: .regular, size: 16)
        label.numberOfLines = 0

        return label
    }()

    // MARK: - local Variables

    var writing: Writing?

    // MARK: - LifeCycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()

        setConstraint()
        setNavigationBar()
        setView()
    }
}

// MARK: - Action

extension DetailWritingVC {
    @objc func touchUpBackButton(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }

    @objc func touchUpMoreButton(_ sender: UIButton) {
        let optionMenu = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        let deleteAction = UIAlertAction(title: "글 삭제", style: .destructive, handler: nil)
        let editAction = UIAlertAction(title: "글 수정", style: .default, handler: didSelectedEditButton(_:))

        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)

        optionMenu.addAction(editAction)
        optionMenu.addAction(deleteAction)
        optionMenu.addAction(cancelAction)

        present(optionMenu, animated: true, completion: nil)
    }

    @objc func didSelectedEditButton(_ sender: UIAlertAction) {
        let writingVC = WritingVC()
        writingVC.writing = writing

        let navigationController = UINavigationController(rootViewController: writingVC)
        navigationController.modalPresentationStyle = .overFullScreen

        present(navigationController, animated: true, completion: nil)
    }
}

// MARK: - Custom Method

extension DetailWritingVC {
    func setConstraint() {
        view.addSubviews([navigationView, backButton, moreButton, separator, titleLabel, dateLabel, contentLabel])
        navigationView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(44)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(48)
        }

        backButton.snp.makeConstraints { make in
            make.leading.equalTo(navigationView.snp.leading)
            make.centerY.equalTo(navigationView.snp.centerY)
            make.width.height.equalTo(navigationView.snp.height)
        }

        moreButton.snp.makeConstraints { make in
            make.trailing.equalTo(navigationView.snp.trailing)
            make.centerY.equalTo(navigationView.snp.centerY)
            make.width.height.equalTo(navigationView.snp.height)
        }

        separator.snp.makeConstraints { make in
            make.top.equalTo(navigationView.snp.bottom)
            make.leading.trailing.equalTo(navigationView)
            make.height.equalTo(1)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(navigationView).offset(80)
            make.leading.trailing.equalToSuperview().inset(30)
        }

        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
            make.leading.equalTo(titleLabel.snp.leading)
            make.trailing.equalTo(titleLabel.snp.trailing)
        }

        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(40)
            make.leading.equalTo(titleLabel.snp.leading)
            make.trailing.equalTo(titleLabel.snp.trailing)
        }
    }

    func setNavigationBar() {
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
    }

    func setView() {
        view.backgroundColor = .white

        if let writing = self.writing {
            titleLabel.text = writing.title
            contentLabel.text = writing.content
            dateLabel.text = Date().getDateToString(format: "yyyy년 M월 d일 E a h:mm", date: writing.date)
        }
    }
}
