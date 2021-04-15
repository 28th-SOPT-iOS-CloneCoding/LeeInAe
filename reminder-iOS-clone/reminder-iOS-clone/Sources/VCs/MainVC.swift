//
//  ViewController.swift
//  reminder-iOS-clone
//
//  Created by inae Lee on 2021/04/13.
//

import UIKit

class MainVC: UIViewController {
    // MARK: - local variables

    var isEditingMode: Bool = false
    var menuDic = [MainMenu.todo: true, MainMenu.assign: true, MainMenu.flag: true, MainMenu.today: false, MainMenu.total: false]

    lazy var editButton: UIBarButtonItem = {
        let editButton = UIBarButtonItem(title: "편집", style: .plain, target: self, action: #selector(self.pressEditButton(_:)))
        editButton.title = "편집"
        return editButton
    }()

    lazy var searchController: UISearchController = {
        let searchController = UISearchController()
        searchController.searchBar.placeholder = "검색"
        return searchController
    }()

    // MARK: - IBOutlets

    @IBOutlet var mainMenuCV: UICollectionView!

    // MARK: - lifeCycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()

        mainMenuCV.delegate = self
        mainMenuCV.dataSource = self

        let layoutConfig = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        let listLayout = UICollectionViewCompositionalLayout.list(using: layoutConfig)
//
        mainMenuCV.collectionViewLayout = listLayout
        mainMenuCV.translatesAutoresizingMaskIntoConstraints = false
//        self.navigationController?.navigationBar.shadowImage = UIImage()
        navigationItem.rightBarButtonItem = editButton
        navigationItem.searchController = searchController
        navigationItem.title = ""
    }

    // MARK: - Custom Methods

    // MARK: - @objc Methods

    @objc func pressEditButton(_ sender: UIBarButtonItem) {
        if isEditingMode {
            editButton.title = "편집"
            isEditingMode = false
        } else {
            editButton.title = "완료"
            isEditingMode = true
        }
    }
}

extension MainVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 4 {
            return CGSize(width: collectionView.bounds.width, height: 50)
        } else {
            return CGSize(width: collectionView.bounds.width / 2, height: 50)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension MainVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        5
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainMenuCell", for: indexPath) as? MainMenuCell else { return UICollectionViewCell() }

        cell.setLabel(idx: indexPath.section)
        return cell
    }
}
