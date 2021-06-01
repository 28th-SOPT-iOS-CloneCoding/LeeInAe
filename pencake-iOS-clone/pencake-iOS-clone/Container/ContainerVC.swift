//
//  ContainerVC.swift
//  pencake-iOS-clone
//
//  Created by inae Lee on 2021/05/26.
//

import RealmSwift
import UIKit

class ContainerVC: UIPageViewController {
    // MARK: - UIComponents

    private lazy var moreButton: UIButton = {
        let button = UIButton(frame: CGRect(origin: .zero, size: CGSize(width: 60, height: 60)))
        button.addTarget(self, action: #selector(touchUpMoreButton(_:)), for: .touchUpInside)
        button.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        button.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(scale: .large), forImageIn: .normal)
        button.tintColor = UIColor.lightGray
        button.backgroundColor = .white

        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.lightGray.cgColor

        return button
    }()

    // MARK: - Local Variables

    // FIXME: - (임시) 데이터 베이스로 옮기거나 userDefaults
    static var pages: [UIViewController] = [UINavigationController(rootViewController: StoryVC()), AddStoryVC()]
    private var currPage: Int = 0

    // MARK: - local variables

    let realm = try! Realm()

    // MARK: - LifeCycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()

        let rappers = realm.objects(Story.self)
        print(rappers)

        print(Realm.Configuration.defaultConfiguration.fileURL)

        setConstraint()
        setPageController()
    }
}

// MARK: - Action Methods

extension ContainerVC {
    @objc func touchUpMoreButton(_ sender: UIButton) {
        print("👍 currPage: \(currPage)")
    }
}

// MARK: - Custom Methods

extension ContainerVC {
    private func setPageController() {
        setViewControllers([ContainerVC.pages[currPage]], direction: .forward, animated: true, completion: nil)

        dataSource = self
        delegate = self
    }

    private func setConstraint() {
        view.addSubviews([moreButton])

        moreButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-40)
            make.width.height.equalTo(60)
        }

        moreButton.layer.cornerRadius = moreButton.frame.height / 2
        moreButton.layer.masksToBounds = true
    }
}

// MARK: - UIPageViewControllerDelegate

extension ContainerVC: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            if let currVC = viewControllers?.first {
                guard let idx = ContainerVC.pages.firstIndex(of: currVC) else { return }
                currPage = idx
            }
        }
    }
}

// MARK: - UIPageViewControllerDataSource

extension ContainerVC: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let idx = ContainerVC.pages.firstIndex(of: viewController) else { return nil }

        return idx - 1 < 0 ? nil : ContainerVC.pages[idx - 1]
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let idx = ContainerVC.pages.firstIndex(of: viewController) else { return nil }

        return idx + 1 >= ContainerVC.pages.count ? nil : ContainerVC.pages[idx + 1]
    }
}
