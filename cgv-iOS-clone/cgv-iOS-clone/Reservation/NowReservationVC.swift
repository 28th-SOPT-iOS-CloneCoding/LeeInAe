//
//  NowReservationVC.swift
//  cgv-iOS-clone
//
//  Created by inae Lee on 2021/05/19.
//

import UIKit

class NowReservationVC: UIViewController {
    // MARK: - UIComponents

    private let popUpView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.cornerRound(radius: 18)

        return view
    }()

    private let drawerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        view.cornerRound(radius: 3)

        return view
    }()

    // MARK: - LifeCycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()

        /// 임시
        view.backgroundColor = UIColor(white: 0, alpha: 0.6)
        
        setConstraint()
    }
}

// MARK: - Custom Methods

extension NowReservationVC {
    func setConstraint() {
        view.addSubviews([popUpView, drawerView])

        popUpView.snp.makeConstraints { make in
            make.leading.bottom.trailing.equalToSuperview()
            make.height.equalTo(500)
        }

        drawerView.snp.makeConstraints { make in
            make.bottom.equalTo(popUpView.snp.top).inset(-10)
            make.width.equalTo(60)
            make.height.equalTo(5)
            make.centerX.equalToSuperview()
        }
    }
}
