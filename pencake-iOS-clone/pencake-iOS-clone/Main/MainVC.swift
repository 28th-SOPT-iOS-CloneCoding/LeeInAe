//
//  ViewController.swift
//  pencake-iOS-clone
//
//  Created by inae Lee on 2021/05/25.
//

import SnapKit
import UIKit

class MainVC: UIViewController {
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

extension MainVC {
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
//        tableView.delegate = self
        tableView.dataSource = self
    }
}

// MARK: - UITableViewDataSource

extension MainVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        100
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        UITableViewCell()
    }
}