//
//  ContainerVC.swift
//  pencake-iOS-clone
//
//  Created by inae Lee on 2021/05/26.
//

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

    static var pages: [UIViewController] = [AddStoryVC()]
    static var currPage: Int = ContainerVC.pages.count - 1

    // MARK: - LifeCycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()

        setRealm()
        setConstraint()
        setPageController()
        setNotification()
    }
}

// MARK: - Action Methods

extension ContainerVC {
    @objc func touchUpMoreButton(_ sender: UIButton) {
        print("👍 currPage: \(ContainerVC.currPage)")

        let menuVC = MenuVC()
        menuVC.modalTransitionStyle = .crossDissolve
        menuVC.modalPresentationStyle = .overCurrentContext

        present(menuVC, animated: true, completion: nil)
    }

    @objc func changeCurrPage(_ sender: Notification) {
        guard let newStoryVC = sender.object as? StoryVC else { return }
        guard let idx = ContainerVC.pages.firstIndex(of: newStoryVC) else { return }
        ContainerVC.currPage = idx

        setViewControllers([ContainerVC.pages[idx]], direction: .forward, animated: false, completion: nil)
    }
}

// MARK: - Custom Methods

extension ContainerVC {
    private func setRealm() {
        Database.shared.initStoryData()
    }

    private func setPageController() {
        setViewControllers([ContainerVC.pages[ContainerVC.currPage]], direction: .forward, animated: true, completion: nil)

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

    private func setNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(changeCurrPage(_:)), name: Notification.Name.didSavedNewStory, object: nil)
    }
}

// MARK: - UIPageViewControllerDelegate

extension ContainerVC: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            if let currVC = viewControllers?.first {
                guard let idx = ContainerVC.pages.firstIndex(of: currVC) else { return }
                ContainerVC.currPage = idx
            }
        }
    }
}

// MARK: - UIPageViewControllerDataSource

extension ContainerVC: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let idx = ContainerVC.pages.firstIndex(of: viewController) else { return nil }

        return idx + 1 >= ContainerVC.pages.count ? nil : ContainerVC.pages[idx + 1]
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let idx = ContainerVC.pages.firstIndex(of: viewController) else { return nil }

        return idx - 1 < 0 ? nil : ContainerVC.pages[idx - 1]
    }
}
