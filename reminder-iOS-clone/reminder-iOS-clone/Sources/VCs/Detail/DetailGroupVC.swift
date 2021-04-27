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
    var group: Group?

    // MARK: - IBOutlets

    @IBOutlet var groupTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        initView()
    }
}

// MARK: - Custom Methods

extension DetailGroupVC {
    func initView() {
        if let title = titleLabel {
            groupTableView.largeContentTitle = title
        }

        let detailGroupCellNib = UINib(nibName: DetailGroupCell.identifier, bundle: nil)
        groupTableView.register(detailGroupCellNib, forCellReuseIdentifier: DetailGroupCell.identifier)

        groupTableView.delegate = self
        groupTableView.dataSource = self

        // FIXME: - 외않되
        groupTableView.largeContentTitle = group?.title
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
