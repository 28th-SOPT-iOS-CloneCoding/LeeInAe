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
        table.contentInset = UIEdgeInsets(top: 150, left: 0, bottom: 0, right: 0)
        table.contentOffset.y = -150

        return table
    }()

    private lazy var newWritingControl: UIRefreshControl = {
        let control = UIRefreshControl()
        control.addTarget(self, action: #selector(addNewWriting(_:)), for: .valueChanged)
        control.tintColor = .clear

        return control
    }()

    private let headerView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 150))
        view.backgroundColor = .orange

        return view
    }()

    // MARK: - LifeCycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()

        setView()
        setTableView()
        setConstraint()
        setNavigationBar()
    }
}

// MARK: - Action Methods

extension StoryVC {
    @objc func addNewWriting(_ sender: UIRefreshControl) {
        sender.endRefreshing()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            let writingVC = UINavigationController(rootViewController: WritingVC())
            writingVC.modalPresentationStyle = .overFullScreen

            self.present(writingVC, animated: true, completion: nil)
        }
    }
}

// MARK: - Custom Methods

extension StoryVC {
    func setView() {
        view.backgroundColor = .white
    }

    func setConstraint() {
        view.addSubviews([tableView, headerView])

        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        headerView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(150)
        }
    }

    func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self

        tableView.register(WritingTVC.self, forCellReuseIdentifier: WritingTVC.identifier)
        tableView.refreshControl = newWritingControl

        tableView.separatorStyle = .none
    }

    func setNavigationBar() {
        navigationController?.navigationBar.isHidden = true
    }
}

// MARK: - UITableViewDelegate

extension StoryVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        UIView()
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        .zero
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = 150 - (scrollView.contentOffset.y + 150)
        let height = min(max(y, 100), 300)

        headerView.snp.updateConstraints { make in
            make.height.equalTo(height)
        }
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
