//
//  mainMenuCell.swift
//  reminder-iOS-clone
//
//  Created by inae Lee on 2021/04/20.
//

import UIKit

class MainMenuCell: UITableViewCell {
    static let identifier = "MainMenuCell"

    // MARK: - IBOutlets

    @IBOutlet var verticalStackView: UIStackView!

    func setCell(menuList: [Group]) {
        print(menuList)
        var idx: Int = 0

        for _ in 0 ... ((menuList.count - 1) / 2) {
            let hStackView = UIStackView()
            hStackView.axis = .horizontal
            hStackView.alignment = .fill
            hStackView.distribution = .fillProportionally
            hStackView.spacing = 15

            hStackView.addArrangedSubview(addItemView(group: menuList[idx]))
            idx += 1

            if idx != 3 || idx != menuList.count, idx != 5 {
                hStackView.addArrangedSubview(addItemView(group: menuList[idx]))
                idx += 1
            }

            verticalStackView.addArrangedSubview(hStackView)
        }
    }

    func addItemView(group: Group) -> UIView {
        guard let itemNib = Bundle.main.loadNibNamed(MenuItemView.identifier, owner: self, options: nil) else { return UIView() }
        guard let itemView = itemNib.first as? MenuItemView else { return UIView() }
        itemView.setView(group: group)

        let tapGesture = ItemTapGesture()
        tapGesture.addTarget(self, action: #selector(tapView(_:)))
        tapGesture.group = group
        itemView.addGestureRecognizer(tapGesture)

        return itemView
    }

    @objc func tapView(_ gesture: ItemTapGesture) {
        print("tap")
        print(gesture.group)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
