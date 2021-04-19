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
    var myList: [String] = []

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
    @IBOutlet var mainListTV: UITableView!

    // MARK: - lifeCycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        initView()

        mainMenuCV.dataSource = self
        mainListTV.delegate = self
        mainListTV.dataSource = self

        let layoutConfig = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        let listLayout = UICollectionViewCompositionalLayout.list(using: layoutConfig)
//
        mainMenuCV.collectionViewLayout = listLayout
        mainMenuCV.translatesAutoresizingMaskIntoConstraints = false
        navigationItem.rightBarButtonItem = editButton
        navigationItem.searchController = searchController
    }
}

// MARK: - Custom Methods

extension MainVC {
    func initView() {
        let toolbar = UIToolbar()
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)

        view.addSubview(toolbar)

        toolbar.translatesAutoresizingMaskIntoConstraints = false
//        toolbar.clipsToBounds = true
//        toolbar.backgroundColor = .clear
        toolbar.leadingAnchor.constraint(equalToSystemSpacingAfter: view.safeAreaLayoutGuide.leadingAnchor, multiplier: 0).isActive = true
        toolbar.bottomAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.bottomAnchor, multiplier: 0).isActive = true
        toolbar.trailingAnchor.constraint(equalToSystemSpacingAfter: view.safeAreaLayoutGuide.trailingAnchor, multiplier: 0).isActive = true

        let addReminder = UIBarButtonItem(title: "새로운 미리 알림", style: .plain, target: self, action: #selector(presentAddReminderVC))
        let addList = UIBarButtonItem(title: "목록 추가", style: .plain, target: self, action: #selector(presentAddListVC))

        toolbar.setItems([addReminder, flexibleSpace, addList], animated: true)
    }
}

// extension MainVC {
//    private func createLayout() -> UICollectionViewLayout {
//        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int,
//                                                            _: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
//
//            var columns = 1
//            switch sectionIndex {
//            case 0:
//                columns = 3
//            case 1:
//                columns = 7
//            default:
//                columns = 1
//            }
//
//            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
//                                                  heightDimension: .fractionalHeight(1.0))
//            let item = NSCollectionLayoutItem(layoutSize: itemSize)
//            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
//
//            let groupHeight = columns == 1 ?
//                NSCollectionLayoutDimension.absolute(44) :
//                NSCollectionLayoutDimension.fractionalWidth(0.2)
//            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
//                                                   heightDimension: groupHeight)
//            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: columns)
//
//            let section = NSCollectionLayoutSection(group: group)
//            section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
//
//            return section
//        }
//
//        return layout
//    }
//
//    func configDataSource() {
//        dataSource = UICollectionViewDiffableDataSource<Section, MainMenuItem>(collectionView: mainMenuCV) {
//            (collectionView: UICollectionView, indexPath: IndexPath, _: MainMenuItem) -> UICollectionViewCell? in
//            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainMenuCell", for: indexPath) as? MainMenuCell else {
//                return UICollectionViewCell()
//            }
//            cell.setLabel(idx: indexPath.item)
//
//            return cell
//        }
//    }
// }

// MARK: - @objc Methods

extension MainVC {
    @objc func pressEditButton(_ sender: UIBarButtonItem) {
        if isEditingMode {
            editButton.title = "편집"
            isEditingMode = false
            mainListTV.setEditing(false, animated: true)
        } else {
            editButton.title = "완료"
            isEditingMode = true
            mainListTV.setEditing(true, animated: true)
        }
    }

    @objc func presentAddReminderVC() {
        guard let addReminderVC = storyboard?.instantiateViewController(identifier: "AddReminderVC") as? AddReminderVC else { return }

        present(addReminderVC, animated: true, completion: nil)
    }

    @objc func presentAddListVC() {
        guard let addListVC = storyboard?.instantiateViewController(identifier: "AddListVC") as? AddListVC else { return }

        present(addListVC, animated: true, completion: nil)
    }
}

// MARK: - UICollectionViewDataSource

extension MainVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        3
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainMenuCell", for: indexPath) as? MainMenuCVC else { return UICollectionViewCell() }
        cell.setLabel(idx: indexPath.item)

        return cell
    }
}

// MARK: - UITableViewDelegate

extension MainVC: UITableViewDelegate {}

// MARK: - UITableViewDataSource

extension MainVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        30
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MainListTVC") as? MainListTVC else { return UITableViewCell() }

        cell.setCell()
        cell.accessoryType = .disclosureIndicator

        return cell
    }

//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        String("나의 목록")
//    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let info = UIContextualAction(style: .normal, title: "info") { _, _, completion in
            completion(true)
        }

        let delete = UIContextualAction(style: .destructive, title: "delete") { _, _, completion in
            completion(true)
        }

        return UISwipeActionsConfiguration(actions: [delete, info])
    }

    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {}
}
