//
//  RadioButton.swift
//  reminder-iOS-clone
//
//  Created by inae Lee on 2021/04/23.
//

import UIKit

class RadioButton: UIButton {
    var icon: String?
    var bgColor: UIColor?

    lazy var colorButton: UIButton = {
        let width = self.bounds.width - 10
        let colorButton = UIButton(frame: CGRect(x: 0, y: 0, width: width, height: width))
        colorButton.center = CGPoint(x: self.bounds.width / 2, y: self.bounds.height / 2)
        colorButton.layer.cornerRadius = width / 2
        colorButton.backgroundColor = .red
        colorButton.isUserInteractionEnabled = false

        return colorButton
    }()

    var isChecked: Bool = false {
        didSet {}
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initButton()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initButton()
    }

    func initButton() {
        self.setTitle("", for: .normal)
        self.layer.cornerRadius = self.bounds.width / 2
        self.backgroundColor = .white
        self.clipsToBounds = true

        self.addSubview(self.colorButton)
    }

    func setButtonContent(color: UIColor, image: String) {
        self.colorButton.backgroundColor = color
        self.colorButton.tintColor = .darkGray
        self.colorButton.setImage(UIImage(systemName: image), for: .normal)
    }

    func touchUpButton() {
        self.layer.borderColor = UIColor.systemGray4.cgColor
        self.layer.borderWidth = 3.0
    }
}
