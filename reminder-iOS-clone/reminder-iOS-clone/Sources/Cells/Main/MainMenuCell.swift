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

    func setMenuView(menuList: [Group]) {
        print(menuList)
        var idx: Int = 0

        for _ in 0 ... ((menuList.count - 1) / 2) {
            let hStackView = UIStackView()
            hStackView.axis = .horizontal
            hStackView.alignment = .fill
            hStackView.distribution = .fillProportionally
            hStackView.spacing = 10
            hStackView.backgroundColor = .green

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
        let itemView = UIView()
        itemView.backgroundColor = .purple
        itemView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        itemView.layer.cornerRadius = 18

        let icon = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        icon.titleLabel?.text = "씨발"
        icon.backgroundColor = .red
        icon.layer.cornerRadius = icon.bounds.width / 2

        let countLabel = UILabel()
        countLabel.text = "\(group.todos.count)"
        countLabel.font = .systemFont(ofSize: 24, weight: .bold)

        let titleLabel = UILabel()
        titleLabel.text = group.title
        titleLabel.font = .systemFont(ofSize: 15, weight: .medium)
        titleLabel.textColor = .systemGray

        itemView.addSubview(icon)
        itemView.addSubview(countLabel)
        itemView.addSubview(titleLabel)

        icon.leadingAnchor.constraint(equalTo: itemView.leadingAnchor, constant: 10).isActive = true
        icon.topAnchor.constraint(equalTo: itemView.topAnchor, constant: 10).isActive = true

        countLabel.trailingAnchor.constraint(equalTo: itemView.trailingAnchor, constant: 10).isActive = true
        countLabel.centerYAnchor.constraint(equalTo: icon.centerYAnchor).isActive = true

        return itemView
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
