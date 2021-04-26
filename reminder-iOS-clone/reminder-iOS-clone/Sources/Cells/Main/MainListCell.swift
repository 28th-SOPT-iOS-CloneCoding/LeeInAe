//
//  MainListCell.swift
//  reminder-iOS-clone
//
//  Created by inae Lee on 2021/04/21.
//

import UIKit

class MainListCell: UITableViewCell {
    static let identifier = "MainListCell"

    @IBOutlet var icon: UIButton!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var countLabel: UILabel!

    func setCell(group: Group) {
        backgroundColor = .white
        layer.cornerRadius = 18

        icon.setTitle(.none, for: .normal)
        icon.tintColor = .white
        icon.layer.cornerRadius = icon.bounds.width / 2
        icon.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(weight: .light), forImageIn: .normal)
        icon.isUserInteractionEnabled = false
        icon.initButtonByGroup(group: group)

        countLabel.text = "\(group.todos.count)"
        countLabel.font = .systemFont(ofSize: 15)
        countLabel.textColor = .systemGray

        if let groupTitle = group.title,
           let groupIcon = group.icon
        {
            titleLabel.text = "\(groupTitle)"
            icon.setImage(UIImage(systemName: groupIcon), for: .normal)
        }
        titleLabel.font = .systemFont(ofSize: 15)

        accessoryType = .disclosureIndicator
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
