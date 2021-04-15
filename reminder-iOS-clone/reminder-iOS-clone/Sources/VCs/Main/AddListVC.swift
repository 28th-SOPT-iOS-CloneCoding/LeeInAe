//
//  AddListVC.swift
//  reminder-iOS-clone
//
//  Created by inae Lee on 2021/04/16.
//

import UIKit

class AddListVC: UIViewController {
    // MARK: - IBOutlets

    @IBOutlet var addButton: UIBarButtonItem!

    // MARK: - LifeCycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }

    @IBAction func dismiss(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - Custom Methods

extension AddListVC {
    func initView() {
        addButton.isEnabled = false
    }
}
