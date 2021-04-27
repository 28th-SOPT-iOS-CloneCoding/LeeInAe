//
//  DetailGroupCell.swift
//  reminder-iOS-clone
//
//  Created by inae Lee on 2021/04/27.
//

import UIKit

class DetailGroupCell: UITableViewCell {
    static let identifier = "DetailGroupCell"

    @IBOutlet var circleView: UIView!
    @IBOutlet var radioButton: RadioButton!

    var color: UIColor?

    override func awakeFromNib() {
        super.awakeFromNib()

        circleView.layer.borderWidth = 1.4
        circleView.layer.borderColor = .init(gray: 0.6, alpha: 1)
        circleView.layer.cornerRadius = circleView.bounds.width / 2
        
        radioButton.bgColor = .red
        radioButton.isChecked = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    // FIXME: - color 로컬 변수로 바꾸기
    @IBAction func touchUpRadionBtn(_ sender: Any) {
        print("눌렀슴니다요")
        radioButton.touchUpButton(color: .red, borderSize: 1.4)
    }
}
