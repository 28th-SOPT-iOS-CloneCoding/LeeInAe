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
    var group: Group? {
        didSet {
            color = group?.color
        }
    }

    // MARK: - IBOutlets

    @IBOutlet var groupTableView: UITableView!

//    override func viewWillAppear(_ animated: Bool) {
//        print("viewWillAppear")
//        print(groupTableView.contentInset)
//        print(groupTableView.adjustedContentInset)
//    }

//
//    override func viewDidLayoutSubviews() {
//        print("viewDidLayoutSubviews")
//        print(self.title)
//        print(self.groupTableView.adjustedContentInset)
//        print(self.groupTableView.contentInset)
//    }
//
//    override func viewWillLayoutSubviews() {
//        print("viewWillLayoutSubviews")
//        print(groupTableView.contentInset)
//        print(groupTableView.adjustedContentInset)
//    }

    override func viewDidLoad() {
        super.viewDidLoad()

        initView()
        initToolbar()
        initBarButtonItem()
    }

//    override func viewSafeAreaInsetsDidChange() {
//        print("viewSafeAreaInsetsDidChange")
//        print(navigationController?.navigationBar.bounds)
//        print(groupTableView.contentInset)
//        print(groupTableView.adjustedContentInset)
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

        groupTableView.contentInsetAdjustmentBehavior = .never

        navigationController?.navigationBar.topItem?.title = "목록"

        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = group?.title
        navigationController?.navigationItem.largeTitleDisplayMode = .always

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
        let toolbar = UIToolbar()
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)

        view.addSubview(toolbar)

        toolbar.backgroundColor = .clear

        toolbar.translatesAutoresizingMaskIntoConstraints = false
        toolbar.leadingAnchor.constraint(equalToSystemSpacingAfter: view.safeAreaLayoutGuide.leadingAnchor, multiplier: 0).isActive = true
        toolbar.bottomAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.bottomAnchor, multiplier: 0).isActive = true
        toolbar.trailingAnchor.constraint(equalToSystemSpacingAfter: view.safeAreaLayoutGuide.trailingAnchor, multiplier: 0).isActive = true

        let plusButton = UIButton(type: .system)
        plusButton.setTitle("  새로운 미리 알림", for: .normal)
        plusButton.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        plusButton.sizeToFit()

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
            UIAction(title: NSLocalizedString("이름 및 모양", comment: ""), image: UIImage(systemName: "pencil"), handler: menuHandler),
            UIAction(title: NSLocalizedString("목록 공유", comment: ""), image: UIImage(systemName: "person.crop.circle.badge.plus"), handler: menuHandler),
            UIAction(title: NSLocalizedString("미리 알림 선택...", comment: ""), image: UIImage(systemName: "checkmark.circle"), handler: menuHandler),
            UIAction(title: NSLocalizedString("완료된 항목 보기", comment: ""), image: UIImage(systemName: "eye"), handler: menuHandler),
            UIAction(title: NSLocalizedString("목록 삭제", comment: ""), image: UIImage(systemName: "trash")?.withTintColor(.red, renderingMode: .alwaysOriginal), handler: menuHandler)
        ])

        rightButton.menu = barButtonMenu
        navigationItem.rightBarButtonItem = rightButton
    }

    func menuHandler(action: UIAction) {
        Swift.debugPrint("Menu handler: \(action.title)")
    }
}

// MARK: - UITableViewDelegate

extension DetailGroupVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.resignFirstResponder()
    }
}

// MARK: - UITableViewDataSource

extension DetailGroupVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailGroupCell.identifier) as? DetailGroupCell else { return UITableViewCell() }

        // FIXME: - height... 다른 방식 알아보기
        let bottomBorder = CALayer()

        bottomBorder.frame = CGRect(x: 40.0, y: 44.5, width: tableView.bounds.width, height: 0.8)
        bottomBorder.backgroundColor = UIColor.systemGray4.cgColor
        cell.contentView.layer.addSublayer(bottomBorder)

        if let groupColor = group?.color {
            cell.color = groupColor
        }
        cell.delegate = self

        return cell
    }
}

// FIXME: - 동작 안 함..

// MARK: - DetailGroupCellDelegate

extension DetailGroupVC: DetailGroupCellDelegate {
    func updateHeightRow(_ cell: DetailGroupCell, _ textView: UITextView) {
        let size = textView.bounds.size
        let newSize = groupTableView.sizeThatFits(CGSize(width: size.width, height: CGFloat.greatestFiniteMagnitude))

        if size.height != newSize.height {
            print(size.height, newSize.height)
            UIView.setAnimationsEnabled(false)
            groupTableView.beginUpdates()
            groupTableView.endUpdates()
            UIView.setAnimationsEnabled(true)

            if let idx = groupTableView.indexPath(for: cell) {
                groupTableView.scrollToRow(at: idx, at: .bottom, animated: true)
            }
        }
    }
}
