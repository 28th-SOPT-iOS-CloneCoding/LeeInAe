//
//  MainListTVC.swift
//  reminder-iOS-clone
//
//  Created by inae Lee on 2021/04/16.
//

import UIKit

class MainListTVC: UITableViewCell {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var countLabel: UILabel!
    @IBOutlet var circleView: UIView!
    @IBOutlet var iconImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    // MARK: - Custom Methods

    func setCell() {
        titleLabel.text = "웅앵"
        titleLabel.font = .systemFont(ofSize: 16, weight: .medium)

        countLabel.text = "\(0)"
        countLabel.isHidden = false
        countLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        countLabel.textColor = UIColor.gray

//        UIImageView(image: icon?.withRenderingMode(.alwaysTemplate))
//        icon.tintColor = .white

        iconImage.image = UIImage(systemName: "bookmark.fill")
        iconImage.image?.withRenderingMode(.alwaysTemplate)
        iconImage.tintColor = .white

        circleView.backgroundColor = .orange
        circleView.layer.cornerRadius = circleView.bounds.width / 2
    }
}
