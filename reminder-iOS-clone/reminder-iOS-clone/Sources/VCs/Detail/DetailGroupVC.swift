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
