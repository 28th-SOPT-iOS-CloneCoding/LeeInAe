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
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 120
        tableView.rowHeight = UITableView.automaticDimension

        tableView.register(MovieChartTVC.self, forCellReuseIdentifier: MovieChartTVC.identifier)

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
        print(sender.selectedSegmentIndex)
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
//                    print("😻 : ", data)
                    self.movieChartList = data.results
                    self.tableView.reloadData()
                } catch {
                    print("parsing error")
                }
            case .failure(let err):
                print(err)
            }
        }
    }
}

// MARK: - UITableViewDelegate

extension MoreMovieChartVC: UITableViewDelegate {}

// MARK: - UITableViewDataSource

extension MoreMovieChartVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movieChartList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieChartTVC.identifier) as? MovieChartTVC else { return UITableViewCell() }
        let movie = movieChartList[indexPath.row]
        cell.setValue(title: movie.title, poster: movie.posterPath, release: movie.releaseDate, isAdult: movie.adult)

        return cell
    }
}
