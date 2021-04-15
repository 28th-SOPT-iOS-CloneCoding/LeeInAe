//
//  AddReminderVC.swift
//  reminder-iOS-clone
//
//  Created by inae Lee on 2021/04/16.
//

import UIKit

class AddReminderVC: UIViewController {
    // MARK: - IBOutlets

    @IBOutlet var addButton: UIBarButtonItem!

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
    }
}
