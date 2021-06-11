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

    private let headerView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 200))
        view.backgroundColor = .white
        view.clipsToBounds = true

        return view
    }()

    private let separator: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.systemGray5

        return view
    }()

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
        btn.setTitleColor(.black, for: .normal)
        btn.sizeToFit()

        return btn
    }()

    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.backgroundColor = .white
        table.contentInset = UIEdgeInsets(top: 200, left: 0, bottom: 0, right: 0)
        table.contentOffset.y = -200

        return table
    }()

    private lazy var newWritingControl: UIRefreshControl = {
        let control = UIRefreshControl()
        control.addTarget(self, action: #selector(addNewWriting(_:)), for: .valueChanged)
        control.tintColor = .clear

        return control
    }()

    private let guideLabel: UILabel = {
        let label = UILabel()
        label.text = "여기를 아래로 당기면 글을 쓸 수 있어요"
        label.font = UIFont.NotoSerifKR(type: .light, size: 13)
        label.textColor = UIColor.lightGray
        label.isUserInteractionEnabled = false
        label.isHidden = true

        return label
    }()

    // MARK: - local variables

    var viewModel: StoryViewModel

    // MARK: - Initializer

    init(viewModel: StoryViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - LifeCycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()

        setView()
        setViewModel()
        setTableView()
        setConstraint()
        setNavigationBar()
    }
}

// MARK: - Action Methods

extension StoryVC {
    @objc func addNewWriting(_ sender: UIRefreshControl) {
        sender.endRefreshing()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
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

    func setViewModel() {
        viewModel.storyDelegate = self
    }

    func setConstraint() {
        view.addSubviews([tableView, headerView, guideLabel])
        headerView.addSubviews([titleButton, subTitleButton, separator])

        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        headerView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(200)
        }

        separator.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(1)
        }

        titleButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(20)
        }

        subTitleButton.snp.makeConstraints { make in
            make.centerX.equalTo(titleButton.snp.centerX)
            make.top.equalTo(titleButton.snp.bottom).offset(10)
        }

        guideLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(separator.snp.bottom).offset(40)
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
        let y = -scrollView.contentOffset.y
        let height = min(max(y, 100), 250)

        headerView.snp.updateConstraints { make in
            make.height.equalTo(height)
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailWritingVC = DetailWritingVC(viewModel: WritingViewModel())

        if let story = viewModel.story {
            detailWritingVC.writing = story.writings[indexPath.row]
        }

        navigationController?.pushViewController(detailWritingVC, animated: true)
    }
}

// MARK: - UITableViewDataSource

extension StoryVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let story = viewModel.story {
            return story.writings.count
        }

        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WritingTVC.identifier) as? WritingTVC else { return UITableViewCell() }
        cell.selectionStyle = .none

        if let story = viewModel.story {
            cell.setCellData(writing: story.writings[indexPath.row])
        }

        return cell
    }
}

// MARK: - StoryViewModelDelegate

extension StoryVC: StoryViewModelDelegate {
    func didChangedStory(story: Story) {
        titleButton.setTitle(story.title, for: .normal)
        subTitleButton.setTitle(story.subTitle, for: .normal)

        if story.writings.count == 0 {
            guideLabel.isHidden = false
        } else {
            guideLabel.isHidden = true
        }

        tableView.reloadData()
    }
}
