//
//  ViewController.swift
//  cgv-iOS-clone
//
//  Created by inae Lee on 2021/05/10.
//

import UIKit

class MainVC: UIViewController {
    // MARK: - IBOutlets

    private let moreMovieChartButton: UIButton = {
        let button = UIButton()
        button.setTitle("더보기", for: .normal)
        button.setTitleColor(UIColor.red, for: .normal)

        return button
    }()

    // MARK: - Life Cycle Methods

    override func viewWillAppear(_ animated: Bool) {
        view.backgroundColor = .white
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setConstraint()
    }

    // MARK: - Actions
}

// MARK: - Custom Methods

extension MainVC {
    private func setConstraint() {
        view.addSubviews([moreMovieChartButton])

        moreMovieChartButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
}
