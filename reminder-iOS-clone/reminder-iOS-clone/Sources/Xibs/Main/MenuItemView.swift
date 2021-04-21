//
//  MainItemView.swift
//  reminder-iOS-clone
//
//  Created by inae Lee on 2021/04/21.
//

import UIKit

class MenuItemView: UIView {
    static let identifier = "MenuItemView"

    @IBOutlet var icon: UIButton!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var countLabel: UILabel!

    func setView(group: Group) {
        backgroundColor = .white
        layer.cornerRadius = 18

        icon.setTitle(.none, for: .normal)
        icon.tintColor = .white
        icon.layer.cornerRadius = icon.bounds.width / 2
        icon.initButtonByGroup(group: group)
        icon.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(weight: .light), forImageIn: .normal)

        countLabel.text = "\(group.todos.count)"
        countLabel.font = .systemFont(ofSize: 24, weight: .bold)

        titleLabel.text = "\(group.type.rawValue)"
        titleLabel.font = .systemFont(ofSize: 15, weight: .semibold)
        titleLabel.textColor = .systemGray
    }
}
