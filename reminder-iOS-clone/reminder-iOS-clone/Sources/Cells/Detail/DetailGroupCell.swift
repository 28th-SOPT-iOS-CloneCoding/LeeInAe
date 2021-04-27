//
//  DetailGroupCell.swift
//  reminder-iOS-clone
//
//  Created by inae Lee on 2021/04/27.
//

import UIKit

protocol DetailGroupCellDelegate {
    func updateHeightRow(_ cell: DetailGroupCell, _ textView: UITextView)
}

class DetailGroupCell: UITableViewCell {
    static let identifier = "DetailGroupCell"

    @IBOutlet var circleView: UIView!
    @IBOutlet var radioButton: RadioButton!
    @IBOutlet var titleTextView: UITextView!

    var color: UIColor?
    var delegate: DetailGroupCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()

        circleView.layer.borderWidth = 1.4
        circleView.layer.borderColor = .init(gray: 0.6, alpha: 1)
        circleView.layer.cornerRadius = circleView.bounds.width / 2

        radioButton.bgColor = .red
        radioButton.isChecked = false

        titleTextView.text = "새로운 미리 알림"
        titleTextView.isScrollEnabled = false
        titleTextView.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    // FIXME: - color 로컬 변수로 바꾸기 + Noti로 누름 처리 + table delete
    @IBAction func touchUpRadionBtn(_ sender: Any) {
        print("눌렀슴니다요")
        radioButton.touchUpButton(color: .red, borderSize: 1.4)
    }
}

extension DetailGroupCell: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        if let delegate = self.delegate {
            delegate.updateHeightRow(self, titleTextView)
        }
    }
}
