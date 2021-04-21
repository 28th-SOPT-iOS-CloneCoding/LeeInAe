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

    @IBOutlet var mainTableView: UITableView!

    // MARK: - lifeCycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()

        initView()
        initTableView()
    }
}

// MARK: - Custom Methods

extension MainVC {
    func initView() {
        navigationItem.rightBarButtonItem = editButton
        navigationItem.searchController = searchController

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

    func initTableView() {
        mainTableView.delegate = self
        mainTableView.dataSource = self

        let menuNib = UINib(nibName: MainMenuCell.identifier, bundle: nil)
        mainTableView.register(menuNib, forCellReuseIdentifier: MainMenuCell.identifier)

        let listNib = UINib(nibName: MainListCell.identifier, bundle: nil)
        mainTableView.register(listNib, forCellReuseIdentifier: MainListCell.identifier)
    }
}

// MARK: - @objc Methods

extension MainVC {
    @objc func pressEditButton(_ sender: UIBarButtonItem) {
        if isEditingMode {
            editButton.title = "편집"
            isEditingMode = false
            mainTableView.setEditing(false, animated: true)
        } else {
            editButton.title = "완료"
            isEditingMode = true
            mainTableView.setEditing(true, animated: true)
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

// MARK: - UITableViewDelegate

extension MainVC: UITableViewDelegate {
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

// MARK: - UITableViewDataSource

extension MainVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = mainTableView.dequeueReusableCell(withIdentifier: MainMenuCell.identifier) as? MainMenuCell else { return UITableViewCell() }
            cell.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 247/255, alpha: 1)
            cell.setCell(menuList: MainMenu.mainMenu.menuList.filter { $0.isSelect && $0.type != GroupType.custom })

            return cell
        case 1:
            guard let cell = mainTableView.dequeueReusableCell(withIdentifier: MainListCell.identifier) as? MainListCell else { return UITableViewCell() }
            cell.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 247/255, alpha: 1)
            cell.separatorInset = UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 0)
            cell.setCell(group: MainMenu.mainMenu.customGroup[indexPath.item])

            return cell
        default:
            return UITableViewCell()
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return (MainMenu.mainMenu.menuList.filter { $0.type == GroupType.custom }).count
        default:
            return 0
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 1 {
            return String("나의 목록")
        }
        return nil
    }
}
