//
//  MoreMovieChartVC.swift
//  cgv-iOS-clone
//
//  Created by inae Lee on 2021/05/10.
//

import Moya
import SnapKit
import UIKit

enum MovieChart: String {
    case movieChart = "무비차트"
    case artHouse = "아트하우스"
    case upcoming = "개봉예정"
}

class MoreMovieChartVC: UIViewController {
    private let movieProvider = MoyaProvider<MovieService>()

    // MARK: - IBOutlets

    private lazy var tableView: UITableView = {
        let tableView = UITableView()

        return tableView
    }()

    private lazy var segmentControl: UISegmentedControl = {
        let seg = UISegmentedControl(items: segmentItems)
        seg.selectedSegmentIndex = 0
        seg.addTarget(self, action: #selector(changeSegControl(_:)), for: .valueChanged)
        return seg
    }()

    // MARK: - local variable

    let segmentItems: [String] = [MovieChart.movieChart.rawValue, MovieChart.artHouse.rawValue, MovieChart.upcoming.rawValue]
    var movieChartList: [Movie] = []

    // MARK: - LifeCycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        getPopularMovie()

        setConstraints()
    }

    // MARK: - Action Methods

    @objc func changeSegControl(_ sender: UISegmentedControl) {
        print(sender)
    }

    // MARK: - Custom Methods

    func setConstraints() {
        view.addSubviews([segmentControl, tableView])

        segmentControl.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }

        tableView.snp.makeConstraints { make in
            make.top.equalTo(segmentControl.snp.bottom)
            make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }

    func getPopularMovie() {
        movieProvider.request(.getPopular(page: 1)) { response in
            switch response {
            case .success(let result):
                do {
                    let data = try result.map(NetworkResponse.self)
                    print("😻 : ", data)
                    self.movieChartList = data.results
                } catch {
                    print("parsing error")
                }
            case .failure(let err):
                print(err)
            }
        }
    }
}
