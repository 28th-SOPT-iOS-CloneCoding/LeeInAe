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
        print("#############")
        print(self.group)
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

extension DetailGroupVC: UITableViewDelegate {}

// MARK: - UITableViewDataSource

extension DetailGroupVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailGroupCell.identifier) as? DetailGroupCell else { return UITableViewCell() }

        return cell
    }
}
