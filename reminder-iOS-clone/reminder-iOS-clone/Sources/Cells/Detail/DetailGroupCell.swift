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

    var color: UIColor = .blue {
        didSet {
            radioButton.bgColor = color
            radioButton.layer.borderColor = color.cgColor
        }
    }

    override var isSelected: Bool {
        didSet {
            if isSelected {
                let flagImage = UIImageView(image: UIImage(systemName: "info.circle"))

                accessoryView = flagImage
            } else {
                accessoryView = nil
            }
        }
    }

    var delegate: DetailGroupCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()

        circleView.layer.borderWidth = 1.4
        circleView.layer.borderColor = .init(gray: 0.6, alpha: 1)
        circleView.layer.cornerRadius = circleView.bounds.width / 2

        radioButton.isChecked = false

        titleTextView.delegate = self
        titleTextView.text = "새로운 미리 알림"
        titleTextView.isScrollEnabled = false
        titleTextView.autocorrectionType = .no
        titleTextView.isUserInteractionEnabled = false
        titleTextView.isMultipleTouchEnabled = false
        titleTextView.keyboardDismissMode = .interactive

        let bar = UIToolbar()
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)

        let calendar = UIBarButtonItem(image: UIImage(systemName: "calendar.badge.clock"), style: .plain, target: self, action: nil)

        let gps = UIBarButtonItem(image: UIImage(systemName: "location"), style: .plain, target: self, action: nil)

        let flag = UIBarButtonItem(image: UIImage(systemName: "flag"), style: .plain, target: self, action: nil)

        let camera = UIBarButtonItem(image: UIImage(systemName: "camera"), style: .plain, target: self, action: nil)

        bar.items = [flexibleSpace, calendar, flexibleSpace, gps, flexibleSpace, flag, flexibleSpace, camera, flexibleSpace]
        bar.tintColor = .black
        bar.sizeToFit()
        titleTextView.inputAccessoryView = bar
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    // FIXME: - color 로컬 변수로 바꾸기 + Noti로 누름 처리 + table delete
    @IBAction func touchUpRadionBtn(_ sender: Any) {
        print("눌렀슴니다요")
        radioButton.touchUpButton(color: color, borderSize: 1.4)
    }
}

extension DetailGroupCell: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        if let delegate = self.delegate {
            delegate.updateHeightRow(self, titleTextView)
        }
    }
}
