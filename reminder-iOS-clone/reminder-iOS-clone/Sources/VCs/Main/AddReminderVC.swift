//
//  AddReminderVC.swift
//  reminder-iOS-clone
//
//  Created by inae Lee on 2021/04/16.
//

import UIKit

class AddReminderVC: UIViewController {
    static let identifier = "AddReminderVC"

    // MARK: - IBOutlets

    @IBOutlet var addButton: UIBarButtonItem!
    @IBOutlet var newReminderTableView: UITableView!

    // MARK: - local variables

    var isEdit: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }

    // MARK: - IBActions

    @IBAction func dismiss(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - Custom Methods

extension AddReminderVC {
    func initView() {
        addButton.isEnabled = false

        newReminderTableView.delegate = self
        newReminderTableView.dataSource = self

        let recordCell = UINib(nibName: NewReminderRecordCell.identifier, bundle: nil)
        newReminderTableView.register(recordCell, forCellReuseIdentifier: NewReminderRecordCell.identifier)
    }
}

// MARK: - UITableViewDataSource

extension AddReminderVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        }
        return 1
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: NewReminderRecordCell.identifier) as? NewReminderRecordCell else { return UITableViewCell() }

            cell.setCell(idx: indexPath.item)
            cell.textField.becomeFirstResponder()
            return cell

        case 1:
            let cell = UITableViewCell()
            cell.textLabel?.text = "세부사항"
            cell.accessoryType = .disclosureIndicator

            return cell
        case 2:
            let cell = UITableViewCell()
            cell.textLabel?.text = "목록"
            cell.accessoryType = .disclosureIndicator

            return cell
        default:
            return UITableViewCell()
        }
    }
}

// MARK: - UITableViewDelegate

extension AddReminderVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0, indexPath.item == 1 {
            return 80
        }
        return 40
    }
}
