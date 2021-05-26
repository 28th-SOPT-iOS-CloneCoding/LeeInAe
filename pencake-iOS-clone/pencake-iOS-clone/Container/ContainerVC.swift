//
//  ContainerVC.swift
//  pencake-iOS-clone
//
//  Created by inae Lee on 2021/05/26.
//

import UIKit

class ContainerVC: UIPageViewController {
    // MARK: - Local Variables

    // FIXME: - (임시) 데이터 베이스로 옮기거나 userDefaults
    static var pages: [UIViewController] = [StoryVC(), AddStoryVC()]
    private var currPage: Int = 0

    // MARK: - LifeCycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()

        setPageController()
    }
}

// MARK: - Custom Methods

extension ContainerVC {
    private func setPageController() {
        setViewControllers([ContainerVC.pages[currPage]], direction: .forward, animated: true, completion: nil)

        dataSource = self
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
