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

    // MARK: - IBOutlets

    @IBOutlet var groupTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension DetailGroupVC {
    func initView() {
        if let title = titleLabel {
            groupTableView.largeContentTitle = title
        }
    }
}
