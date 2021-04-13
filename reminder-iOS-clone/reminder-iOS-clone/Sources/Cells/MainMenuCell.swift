//
//  MainMenuCell.swift
//  reminder-iOS-clone
//
//  Created by inae Lee on 2021/04/14.
//

import UIKit

class MainMenuCell: UITableViewCell {
    override var frame: CGRect {
        get {
            return super.frame
        }
        
        set (newFrame) {
            var frame = newFrame
            frame.origin.x += 20
            frame.size.width = 100
            super.frame = frame
        }
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
