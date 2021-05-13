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
        button.addTarget(self, action: #selector(presentMoreMovieVC(_:)), for: .touchUpInside)

        return button
    }()

    // MARK: - Life Cycle Methods

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.shadowImage = UIImage()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setConstraint()
    }

    // MARK: - Actions

    @objc func presentMoreMovieVC(_ sender: UIButton) {
        let moreMovieChartVC = MoreMovieChartVC()

        navigationController?.pushViewController(moreMovieChartVC, animated: true)
    }
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
