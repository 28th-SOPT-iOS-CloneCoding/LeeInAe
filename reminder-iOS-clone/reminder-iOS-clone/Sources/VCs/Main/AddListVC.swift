//
//  AddListVC.swift
//  reminder-iOS-clone
//
//  Created by inae Lee on 2021/04/16.
//

import UIKit

class AddListVC: UIViewController {
    // MARK: - local variables

    let colors: [UIColor] = [UIColor.red, UIColor.orange, UIColor.yellow, UIColor.green, UIColor.blue, UIColor.systemBlue, UIColor.purple, UIColor.systemPink, UIColor.systemTeal, UIColor.brown, UIColor.darkGray, UIColor.cyan]

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

        paletteCollectionView.delegate = self
        paletteCollectionView.dataSource = self
    }
}

extension AddListVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        8
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        10
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
    }
}

extension AddListVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        12
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RadioButtonCell.identifier, for: indexPath) as? RadioButtonCell else { return UICollectionViewCell() }

        cell.colorButton.setButtonContent(color: colors[indexPath.item], image: "")
        return cell
    }
}
