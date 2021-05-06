//
//  DetailMenuVC.swift
//  reminder-iOS-clone
//
//  Created by inae Lee on 2021/05/05.
//

import UIKit

class DetailMenuVC: UIViewController {
    static let identifier = "DetailMenuVC"

    // MARK: - Local variables

    var titleLabel: String?
    var color: UIColor?

    var group: Group? {
        didSet {
            color = group?.color
        }
    }

    var selectedCount = 0 {
        willSet(newValue) {
            if newValue == 0, !menuTableView.isEditing {
                navigationItem.title = group?.title
            } else {
                navigationItem.title = "선택된 항목 \(newValue)"
            }
        }
    }

    var reminderCount = 0 {
        willSet(newValue) {
            if newValue == 0 {
                showEmptyView()
            } else {
                hideEmptyLabel()
            }
        }
    }

    lazy var emptyLabel = UILabel()

    // MARK: - IBOutlets

    @IBOutlet var menuTableView: UITableView!

    // MARK: - Life Cycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()

        initView()
        initBarButtonItem()

        guard let currGroup = group else { return }
        reminderCount = currGroup.todos.count
        if currGroup.type == GroupType.today {
            initToolbar()
        }
    }
}

// MARK: - Custom Methods

extension DetailMenuVC {
    func initView() {
        if let title = titleLabel {
            menuTableView.largeContentTitle = title
        }

        let detailGroupCellNib = UINib(nibName: DetailGroupCell.identifier, bundle: nil)
        menuTableView.register(detailGroupCellNib, forCellReuseIdentifier: DetailGroupCell.identifier)

        menuTableView.delegate = self
        menuTableView.dataSource = self
        menuTableView.allowsMultipleSelectionDuringEditing = true

        menuTableView.contentInsetAdjustmentBehavior = .never

        navigationItem.title = group?.title
        navigationItem.largeTitleDisplayMode = .always

        if let currColor = color {
            if #available(iOS 11.0, *) {
                navigationController?.navigationBar.prefersLargeTitles = true
                navigationController?.navigationBar.largeTitleTextAttributes = [
                    NSAttributedString.Key.foregroundColor: currColor
                ]
            }
        }

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(touchTableView(_:)))
        menuTableView.addGestureRecognizer(tapGesture)
    }

    func initToolbar() {
        /// 레이아웃 제약조건이 중복되어 변경함 (width가 0으로 들어감 -> fixed 해준다)
        /// 혹은 updateConstraintsIfNeeded() 호출
        let toolbar = UIToolbar(frame: CGRect(origin: .zero, size: CGSize(width: view.bounds.width, height: 44)))

        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)

        view.addSubview(toolbar)

        toolbar.backgroundColor = .clear

        toolbar.translatesAutoresizingMaskIntoConstraints = false
        toolbar.leadingAnchor.constraint(equalToSystemSpacingAfter: view.safeAreaLayoutGuide.leadingAnchor, multiplier: 0).isActive = true
        toolbar.bottomAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.bottomAnchor, multiplier: 0).isActive = true
        toolbar.trailingAnchor.constraint(equalToSystemSpacingAfter: view.safeAreaLayoutGuide.trailingAnchor, multiplier: 0).isActive = true

        let addAction = UIAction { _ in
            if let count = self.group?.todos.count {
                self.reminderCount = count + 1
                self.group?.todos.append(Todo(title: "메롱", memo: "", url: "", flag: false))

                self.menuTableView.insertRows(at: [IndexPath(row: count, section: 0)], with: .none)

                guard let cell = self.menuTableView.cellForRow(at: IndexPath(row: count, section: 0)) as? DetailGroupCell else { return }
                cell.titleTextView.becomeFirstResponder()
                cell.titleTextView.text = .none
            }
        }

        let plusButton = UIButton(type: .system)
        plusButton.setTitle("  새로운 미리 알림", for: .normal)
        plusButton.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        plusButton.sizeToFit()
        plusButton.addAction(addAction, for: .touchUpInside)

        let addReminder = UIBarButtonItem(customView: plusButton)

        toolbar.setItems([addReminder, flexibleSpace], animated: true)
    }

    func initBarButtonItem() {
        let rightButton = UIBarButtonItem(image: UIImage(systemName: "ellipsis.circle"))

        let trashButton = UIButton()
        trashButton.setImage(UIImage(systemName: "trash"), for: .normal)
        trashButton.titleLabel?.text = "목록 삭제"
        trashButton.tintColor = .red

        let barButtonMenu = UIMenu(title: "", children: [
            UIAction(title: NSLocalizedString("미리 알림 선택...", comment: ""), image: UIImage(systemName: "checkmark.circle"), handler: selectReminder),
            UIAction(title: NSLocalizedString("완료된 항목 보기", comment: ""), image: UIImage(systemName: "eye"), handler: menuHandler)
        ])

        rightButton.menu = barButtonMenu
        navigationItem.rightBarButtonItem = rightButton
    }

    func initCompleteButton() {
        let rightButton = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(completeEditTable(_:)))

        navigationItem.rightBarButtonItem = rightButton
    }

    func showEmptyView() {
        emptyLabel.text = "미리 알림 없음"
        emptyLabel.textColor = .lightGray
        emptyLabel.font = UIFont.systemFont(ofSize: 15)
        emptyLabel.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(emptyLabel)

        emptyLabel.centerXAnchor.constraint(equalTo: menuTableView.centerXAnchor).isActive = true
        emptyLabel.centerYAnchor.constraint(equalTo: menuTableView.centerYAnchor).isActive = true
    }

    func hideEmptyLabel() {
        emptyLabel.removeFromSuperview()
    }

    func menuHandler(action: UIAction) {
        Swift.debugPrint("Menu handler: \(action.title)")
    }

    func presentAddListVC(action: UIAction) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let addListVC = storyboard.instantiateViewController(withIdentifier: AddListVC.identifier) as? AddListVC else { return }

        present(addListVC, animated: true, completion: nil)
    }

    func selectReminder(action: UIAction) {
        initCompleteButton()

        menuTableView.isEditing = true
        menuTableView.setEditing(true, animated: true)

        isHiddenRadioButton(true)
    }

    func isHiddenRadioButton(_ isHidden: Bool) {
        guard let cells = menuTableView.visibleCells as? [DetailGroupCell] else {
            return
        }

        cells.map {
            $0.circleView.isHidden = isHidden
            $0.radioButton.isHidden = isHidden
        }
    }
}

// MARK: - @objc Methods

extension DetailMenuVC {
    @objc func completeEditTable(_ sender: UIButton) {
        navigationItem.title = group?.title
        initBarButtonItem()

        menuTableView.isEditing = false
        menuTableView.setEditing(false, animated: true)

        isHiddenRadioButton(false)
    }

    /// cancelsTouchesInView: 탭 제스처가 제스처를 인식하면 나머지 터치 정보를 뷰로 전달하지 않고 이전에 전달된 터치는 취소됨 (기본값 true일 때)
    /// false인 경우 제스처 인식 후에도  터치 정보를 뷰로도 전달함
    @objc func touchTableView(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
        sender.cancelsTouchesInView = false
    }
}

// MARK: - UITableViewDelegate

extension DetailMenuVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        UIView()
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        1
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        UIView()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? DetailGroupCell else { return }
        cell.titleTextView.becomeFirstResponder()
        cell.isSelected = true

        if tableView.isEditing {
            selectedCount = tableView.indexPathsForSelectedRows?.count ?? 0
        }
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if tableView.isEditing {
            selectedCount = tableView.indexPathsForSelectedRows?.count ?? 0
        }
    }

    func tableView(_ tableView: UITableView, didEndEditingRowAt indexPath: IndexPath?) {
        selectedCount = 0
    }
}

// MARK: - UITableViewDataSource

extension DetailMenuVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        group?.todos.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailGroupCell.identifier) as? DetailGroupCell else { return UITableViewCell() }
        cell.selectionStyle = .blue

        if let groupColor = group?.color {
            cell.color = groupColor
        }
        return cell
    }
}
