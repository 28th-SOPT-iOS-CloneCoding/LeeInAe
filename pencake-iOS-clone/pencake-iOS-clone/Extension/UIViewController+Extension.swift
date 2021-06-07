//
//  UIViewController+Extension.swift
//  pencake-iOS-clone
//
//  Created by inae Lee on 2021/06/07.
//

import Foundation
import UIKit

extension UIViewController {
    func sorryAlert(message: String) {
        let alert = UIAlertController(title: "- 죄 송 -", message: message, preferredStyle: .alert)
        let submitAction = UIAlertAction(title: "용서하기", style: .default, handler: nil)
        alert.addAction(submitAction)

        self.present(alert, animated: true, completion: nil)
    }
}
