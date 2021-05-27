//
//  ViewController.swift
//  pencake-iOS-clone
//
//  Created by inae Lee on 2021/05/25.
//

import SnapKit
import UIKit

class StoryVC: UIViewController {
    // MARK: - UIComponents

    private let titleButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("이야기 1", for: .normal)
        btn.titleLabel?.font = UIFont.NotoSerifKR(type: .bold, size: 20)
        btn.setTitleColor(.black, for: .normal)
        btn.sizeToFit()

        return btn
    }()

    private let subTitleButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("여기를 눌러서 제목을 변경하세요", for: .normal)
        btn.titleLabel?.font = UIFont.NotoSerifKR(type: .regular, size: 18)
        btn.tintColor = .black
        btn.sizeToFit()

        return btn
    }()

    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)

        return table
    }()

    // MARK: - LifeCycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()

        setView()
        setTableView()
        setConstraint()
    }
}

// MARK: - Custom Methods

extension StoryVC {
    func setView() {
        view.backgroundColor = .white
    }

    func setConstraint() {
        view.addSubviews([tableView])

        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self

        tableView.register(WritingTVC.self, forCellReuseIdentifier: WritingTVC.identifier)
        
        tableView.separatorStyle = .none
    }
}

// MARK: - UITableViewDelegate

extension StoryVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView()
        header.backgroundColor = .blue

        return header
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        150
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
}

// MARK: - UITableViewDataSource

extension StoryVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        100
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WritingTVC.identifier) as? WritingTVC else { return UITableViewCell() }

        return cell
    }
}
