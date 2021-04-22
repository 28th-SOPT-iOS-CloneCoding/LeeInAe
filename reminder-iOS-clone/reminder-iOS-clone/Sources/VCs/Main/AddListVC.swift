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
    @IBOutlet var groupIcon: UIButton!
    @IBOutlet var groupTitleTextField: UITextField!
    @IBOutlet var paletteCollectionView: UICollectionView!

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

        groupIcon.layoutIfNeeded()
        groupIcon.backgroundColor = .blue
        groupIcon.layer.cornerRadius = groupIcon.bounds.size.width / 2
        groupIcon.setImage(UIImage(systemName: "list.bullet"), for: .normal)
        groupIcon.setTitle(.none, for: .normal)
        groupIcon.tintColor = .white
        groupIcon.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 50, weight: .bold), forImageIn: .normal)
        groupIcon.isUserInteractionEnabled = false

        groupTitleTextField.borderStyle = .none
        groupTitleTextField.layer.cornerRadius = 12
        groupTitleTextField.backgroundColor = .systemGray5
        groupTitleTextField.textAlignment = .center
        groupTitleTextField.becomeFirstResponder()
    }
}
