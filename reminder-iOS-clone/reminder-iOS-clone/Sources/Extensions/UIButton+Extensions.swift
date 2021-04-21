//
//  UIButton+Extensions.swift
//  reminder-iOS-clone
//
//  Created by inae Lee on 2021/04/21.
//

import UIKit

extension UIButton {
    func initButtonByGroup(group: Group) {
        let groupType = group.type

        switch groupType {
        case .today:
            backgroundColor = .blue
            setImage(UIImage(systemName: "calendar"), for: .normal)
        case .todo:
            backgroundColor = .red
            setImage(UIImage(systemName: "calendar"), for: .normal)
        case .forMe:
            backgroundColor = .systemGreen
            setImage(UIImage(systemName: "person.fill"), for: .normal)
        case .total:
            backgroundColor = .darkGray
            setImage(UIImage(systemName: "tray.fill"), for: .normal)
        case .flag:
            backgroundColor = .orange
            setImage(UIImage(systemName: "flag.fill"), for: .normal)
        case .custom:
            backgroundColor = group.color
            setTitle(group.icon, for: .normal)
        }
    }
}
