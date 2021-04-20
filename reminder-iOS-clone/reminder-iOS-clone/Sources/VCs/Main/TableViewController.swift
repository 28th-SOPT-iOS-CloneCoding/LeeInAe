//
//  TableViewController.swift
//  reminder-iOS-clone
//
//  Created by inae Lee on 2021/04/19.
//

import UIKit

class TableViewController: UIViewController {
    @IBOutlet var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource = self
    }
    
    @IBAction func touchButton(_ sender: Any) {
        guard let cell = tableview.sec
    }
}

extension TableViewController: UITableViewDelegate {}

extension TableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            let cell = UITableViewCell()
            cell.backgroundColor = .red
            
            return cell
        } else {
            let cell = UITableViewCell()
            cell.backgroundColor = .blue
            
            return cell

        }
    }
}
