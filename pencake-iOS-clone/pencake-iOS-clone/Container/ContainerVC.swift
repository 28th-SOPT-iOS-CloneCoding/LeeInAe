//
//  ContainerVC.swift
//  pencake-iOS-clone
//
//  Created by inae Lee on 2021/05/26.
//

import UIKit

class ContainerVC: UIPageViewController {
    // MARK: - Local Variables

    var pages: [UIViewController] = [StoryVC(), AddStoryVC()]
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
        setViewControllers([pages[currPage]], direction: .forward, animated: true, completion: nil)

        dataSource = self
    }
}

// MARK: - UIPageViewControllerDataSource

extension ContainerVC: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let idx = pages.firstIndex(of: viewController) else { return nil }

        return idx - 1 < 0 ? nil : pages[idx - 1]
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let idx = pages.firstIndex(of: viewController) else { return nil }

        return idx + 1 >= pages.count ? nil : pages[idx + 1]
    }
}
