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

    @IBOutlet var mainTableView: UITableView!

    // MARK: - lifeCycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        mainTableView.delegate = self
        mainTableView.dataSource = self
//        self.navigationController?.navigationBar.shadowImage = UIImage()
        navigationItem.rightBarButtonItem = editButton
        navigationItem.searchController = searchController
    }

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

extension MainVC: UITableViewDelegate {}

extension MainVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "mainMenuCell") as? MainMenuCell else {
            return UITableViewCell()
        }

        return cell
    }
}
