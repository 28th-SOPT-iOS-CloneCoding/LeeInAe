//
//  DetailGroupVC.swift
//  reminder-iOS-clone
//
//  Created by inae Lee on 2021/04/23.
//

import UIKit

class DetailGroupVC: UIViewController {
    // MARK: - local variables

    static let identifier = "DetailGroupVC"

    var titleLabel: String?
    var color: UIColor?
    // FIXME: - 1개 -> 0개 처리가 안돰
    var selectedItemCount = 0 {
        willSet {
            if let count = groupTableView.indexPathsForSelectedRows?.count {
                navigationItem.title = "선택된 항목 \(count)개"
            }
        }
    }

    var group: Group? {
        didSet {
            color = group?.color
        }
    }

    // MARK: - IBOutlets

    @IBOutlet var groupTableView: UITableView!

//    override func viewWillAppear(_ animated: Bool) {
//        print("======================================")
//        print("viewWillAppear\n\n")
//        print(navigationItem.title)
//        print(navigationController?.navigationBar.frame)
//        print()
//        print(groupTableView.contentInset)
//        print(groupTableView.adjustedContentInset)
//        print(groupTableView.bounds)
//        print()
//        print(view.safeAreaInsets)
//        print("offset", groupTableView.contentOffset)
//    }
//
//    override func viewDidLayoutSubviews() {
//        print("======================================")
//        print("viewDidLayoutSubviews\n\n")
//        print(navigationItem.title)
//        print(navigationController?.navigationBar.frame)
//        print()
//        print(groupTableView.contentInset)
//        print(groupTableView.adjustedContentInset)
//        print(groupTableView.bounds)
//        print()
//        print(view.safeAreaInsets)
//        print("offset", groupTableView.contentOffset)
//    }
//
//    override func viewWillLayoutSubviews() {
//        print("======================================")
//        print("viewWillLayoutSubviews\n\n")
//        print(navigationItem.title)
//        print(navigationController?.navigationBar.frame)
//        print()
//        print(groupTableView.contentInset)
//        print(groupTableView.adjustedContentInset)
//        print(groupTableView.bounds)
//        print()
//        print(view.safeAreaInsets)
//        print("offset", groupTableView.contentOffset)
//    }
//
    override func viewDidLoad() {
        super.viewDidLoad()

        initView()
        initToolbar()
        initBarButtonItem()
    }

//
//    override func viewSafeAreaInsetsDidChange() {
//        print("======================================")
//        print("viewSafeAreaInsetsDidChange\n\n")
//        print(navigationItem.title)
//        print(navigationController?.navigationBar.frame)
//        print()
//        print(groupTableView.contentInset)
//        print(groupTableView.adjustedContentInset)
//        print(groupTableView.bounds)
//        print()
//        print(view.safeAreaInsets)
//        print("offset", groupTableView.contentOffset)
//    }
}

// MARK: - Custom Methods

extension DetailGroupVC {
    func initView() {
        if let title = titleLabel {
            groupTableView.largeContentTitle = title
        }

        let detailGroupCellNib = UINib(nibName: DetailGroupCell.identifier, bundle: nil)
        groupTableView.register(detailGroupCellNib, forCellReuseIdentifier: DetailGroupCell.identifier)

        groupTableView.separatorStyle = .none
        groupTableView.delegate = self
        groupTableView.dataSource = self
        groupTableView.allowsMultipleSelectionDuringEditing = true

        groupTableView.contentInsetAdjustmentBehavior = .never

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
                self.group?.todos.append(Todo(title: "메롱", memo: "", url: "", flag: false))

                self.groupTableView.insertRows(at: [IndexPath(row: count, section: 0)], with: .none)

                guard let cell = self.groupTableView.cellForRow(at: IndexPath(row: count, section: 0)) as? DetailGroupCell else { return }
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
            UIAction(title: NSLocalizedString("이름 및 모양", comment: ""), image: UIImage(systemName: "pencil"), handler: presentAddListVC),
            UIAction(title: NSLocalizedString("목록 공유", comment: ""), image: UIImage(systemName: "person.crop.circle.badge.plus"), handler: menuHandler),
            UIAction(title: NSLocalizedString("미리 알림 선택...", comment: ""), image: UIImage(systemName: "checkmark.circle"), handler: selectReminder),
            UIAction(title: NSLocalizedString("완료된 항목 보기", comment: ""), image: UIImage(systemName: "eye"), handler: menuHandler),
            UIAction(title: NSLocalizedString("목록 삭제", comment: ""), image: UIImage(systemName: "trash")?.withTintColor(.red, renderingMode: .alwaysOriginal), handler: menuHandler)
        ])

        rightButton.menu = barButtonMenu
        navigationItem.rightBarButtonItem = rightButton
    }

    func initCompleteButton() {
        let rightButton = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(completeEditTable(_:)))

        navigationItem.rightBarButtonItem = rightButton
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
        navigationItem.title = "선택된 항목 \(selectedItemCount)개"
        initCompleteButton()

        groupTableView.isEditing = true
        groupTableView.setEditing(true, animated: true)

        isHiddenRadioButton(true)
    }

    func isHiddenRadioButton(_ isHidden: Bool) {
        guard let cells = groupTableView.visibleCells as? [DetailGroupCell] else {
            return
        }

        cells.map {
            $0.circleView.isHidden = isHidden
            $0.radioButton.isHidden = isHidden
        }
    }
}

// MARK: - @objc

extension DetailGroupVC {
    @objc func completeEditTable(_ sender: UIButton) {
        navigationItem.title = group?.title
        initBarButtonItem()

        groupTableView.isEditing = false
        groupTableView.setEditing(false, animated: true)

        isHiddenRadioButton(false)
    }
}

// MARK: - UITableViewDelegate

extension DetailGroupVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? DetailGroupCell else { return }
        cell.titleTextView.becomeFirstResponder()
        cell.isSelected = true

        selectedItemCount += 1
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? DetailGroupCell else { return }
        cell.isSelected = false

        selectedItemCount -= 1
    }
}

// MARK: - UITableViewDataSource

extension DetailGroupVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        group?.todos.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailGroupCell.identifier) as? DetailGroupCell else { return UITableViewCell() }
        cell.selectionStyle = .blue

        // FIXME: - height... 다른 방식 알아보기
        let bottomBorder = CALayer()

        bottomBorder.frame = CGRect(x: 40.0, y: 44.5, width: tableView.bounds.width, height: 0.8)
        bottomBorder.backgroundColor = UIColor.systemGray4.cgColor
        cell.contentView.layer.addSublayer(bottomBorder)

        if let groupColor = group?.color {
            cell.color = groupColor
        }
        return cell
    }
}
