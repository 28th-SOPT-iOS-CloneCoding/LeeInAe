//
//  NewReminderRecordCell.swift
//  reminder-iOS-clone
//
//  Created by inae Lee on 2021/04/22.
//

import UIKit

class NewReminderRecordCell: UITableViewCell {
    static let identifier = "NewReminderRecordCell"

    @IBOutlet var textField: UITextField!
    @IBOutlet var textView: UITextView!

    override func awakeFromNib() {
        super.awakeFromNib()

        let attributes = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)
        ]

        textView.text = ""
        textView.isHidden = true
        textView.delegate = self
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont.systemFont(ofSize: 16, weight: .light)
        setTextView()
        
        textField.attributedPlaceholder = NSAttributedString(string: "제목", attributes: attributes)
        textField.font = UIFont.systemFont(ofSize: 16, weight: .light)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .none
        textField.delegate = self
        textField.resignFirstResponder()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setCell(idx: Int) {
        textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
        textField.topAnchor.constraint(equalTo: topAnchor).isActive = true
        textField.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        textField.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true

        if idx == 1 {
            textField.isHidden = true
            textView.isHidden = false

            textView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 13).isActive = true
            textView.topAnchor.constraint(equalTo: topAnchor).isActive = true
            textView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
            textView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        }
    }
}

extension NewReminderRecordCell {
    func setTextView() {
        if textView.text.count == 0 {
            textView.text = "메모"
            textView.textColor = .systemGray3
        } else {
            textView.text = ""
            textView.textColor = .black
        }
    }
}

extension NewReminderRecordCell: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        setTextView()
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.count == 0 {
            setTextView()
        }
    }
    
}

extension NewReminderRecordCell: UITextFieldDelegate {
}
