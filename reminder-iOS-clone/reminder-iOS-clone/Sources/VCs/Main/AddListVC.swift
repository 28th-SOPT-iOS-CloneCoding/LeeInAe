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
    let icons: [String] = ["list.bullet", "list.bullet", "list.bullet", "list.bullet", "list.bullet", "list.bullet", "list.bullet", "list.bullet", "bookmark.fill", "mappin", "mappin", "mappin", "mappin", "mappin", "mappin", "mappin", "mappin", "mappin", "mappin", "mappin", "mappin", "mappin", "mappin", "mappin", "mappin", "mappin", "mappin", "mappin", "mappin", "mappin", "gift.fill", "circles.hexagongrid.fill"]
    var colorIdx: Int = 5
    var iconIdx: Int = 1

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

// MARK: - Actions

extension AddListVC {
    @objc func editTextField(_ sender: UITextField) {
        if groupTitleTextField.text?.count == 0 {
            addButton.isEnabled = false
        } else {
            addButton.isEnabled = true
        }
    }
}

// MARK: - Custom Methods

extension AddListVC {
    func initView() {
        addButton.isEnabled = false

        groupIcon.layoutIfNeeded()
        groupIcon.backgroundColor = colors[colorIdx]
        groupIcon.layer.cornerRadius = groupIcon.bounds.size.width / 2
        groupIcon.layer.shadowOffset = .init(width: 0, height: 0)
        groupIcon.layer.shadowColor = colors[colorIdx].cgColor
        groupIcon.layer.shadowRadius = 10
        groupIcon.layer.shadowOpacity = 0.8
        groupIcon.layer.shouldRasterize = true
        groupIcon.setImage(UIImage(systemName: "list.bullet"), for: .normal)
        groupIcon.setTitle(.none, for: .normal)
        groupIcon.tintColor = .white
        groupIcon.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 50, weight: .bold), forImageIn: .normal)
        groupIcon.isUserInteractionEnabled = false

        groupTitleTextField.delegate = self
        groupTitleTextField.borderStyle = .none
        groupTitleTextField.layer.cornerRadius = 12
        groupTitleTextField.backgroundColor = .systemGray5
        groupTitleTextField.textAlignment = .center
        groupTitleTextField.font = UIFont.systemFont(ofSize: 18)
        groupTitleTextField.textColor = colors[colorIdx]
        groupTitleTextField.becomeFirstResponder()
        groupTitleTextField.addTarget(self, action: #selector(editTextField(_:)), for: .editingChanged)

        paletteCollectionView.delegate = self
        paletteCollectionView.dataSource = self
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension AddListVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        5
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
    }
}

// MARK: - UICollectionViewDataSource

extension AddListVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 12
        }
        return icons.count
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RadioButtonCell.identifier, for: indexPath) as? RadioButtonCell else { return UICollectionViewCell() }
        cell.colorButton.isUserInteractionEnabled = false

        switch indexPath.section {
        case 0:
            cell.colorButton.setButtonContent(color: colors[indexPath.item], image: "")

            if indexPath.row == colorIdx {
                cell.isSelected = true
            }

            return cell
        case 1:
            cell.colorButton.setButtonContent(color: .systemGray4, image: icons[indexPath.item])

            if indexPath.row == iconIdx {
                cell.isSelected = true
            }

            return cell
        default:
            return UICollectionViewCell()
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            colorIdx = indexPath.row

            groupTitleTextField.textColor = colors[colorIdx]
            groupIcon.backgroundColor = colors[colorIdx]
            groupIcon.layer.shadowColor = colors[colorIdx].cgColor
        } else {
            iconIdx = indexPath.row

            groupIcon.setImage(UIImage(systemName: icons[iconIdx]), for: .normal)
        }

        collectionView.reloadData()
    }
}

// MARK: - UITextFieldDelegate

extension AddListVC: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
