//
//  MainItemView.swift
//  reminder-iOS-clone
//
//  Created by inae Lee on 2021/04/21.
//

import UIKit

class MainItemView: UIView {
    static let identifier = "MainItemView"
    
    @IBOutlet var icon: UIButton!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var countLabel: UILabel!

    func setView(group: Group) {
        icon.backgroundColor = .red
        icon.layer.cornerRadius = icon.bounds.width / 2

        countLabel.text = "\(group.todos.count)"
        countLabel.font = .systemFont(ofSize: 24, weight: .bold)

        titleLabel.text = group.title
        titleLabel.font = .systemFont(ofSize: 15, weight: .medium)
        titleLabel.textColor = .systemGray
    }
}
