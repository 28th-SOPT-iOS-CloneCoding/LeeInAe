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

enum sortCase: Int {
    case popularity = 0
    case vote = 1
}

enum filterCase: Int {
    case nowPlaying = 0
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

        seg.backgroundColor = .clear
        seg.tintColor = .clear

        seg.setBackgroundImage(UIImage(color: .white, size: CGSize(width: UIScreen.main.bounds.width, height: 13)), for: .normal, barMetrics: .default)
        seg.setDividerImage(UIImage(color: .clear), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)

        seg.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.grayTextColor, NSAttributedString.Key.font: UIFont.AppleSDGothic(type: .semiBold, size: 15) ?? UIFont.systemFont(ofSize: 15)], for: .normal)
        seg.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .selected)

        seg.selectedSegmentIndex = 0
        seg.addTarget(self, action: #selector(changeSegControl(_:)), for: .valueChanged)

        return seg
    }()

    private lazy var filterHeaderView: UIView = {
        let view = UIView()

        view.backgroundColor = UIColor.grayViewColor
        // FIXME: - 레이아웃 어디에 뺼 수 없을까...
        view.addSubviews([popularitySortButton, voteSortButton, nowPlayingMovie])

        popularitySortButton.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.leading).inset(10)
            make.centerY.equalTo(view.snp.centerY)
        }

        voteSortButton.snp.makeConstraints { make in
            make.leading.equalTo(popularitySortButton.snp.trailing).inset(-10)
            make.centerY.equalTo(view.snp.centerY)
        }

        nowPlayingMovie.snp.makeConstraints { make in
            make.trailing.equalTo(view.snp.trailing).inset(10)
            make.centerY.equalTo(view.snp.centerY)
        }

        return view
    }()

    private let popularitySortButton: UIButton = {
        let btn = UIButton()
        btn.tag = sortCase.popularity.rawValue
        btn.setTitle("• 인기순", for: .normal)
        btn.setTitleColor(UIColor.grayTextColor, for: .normal)
        btn.setTitleColor(UIColor.black, for: .highlighted)
        btn.titleLabel?.font = UIFont.AppleSDGothic(type: .regular, size: 13)
        btn.addTarget(self, action: #selector(touchUpSort(_:)), for: .touchUpInside)

        return btn
    }()

    private let voteSortButton: UIButton = {
        let btn = UIButton()
        btn.tag = sortCase.vote.rawValue
        btn.setTitle("• 투표율순", for: .normal)
        btn.setTitleColor(UIColor.grayTextColor, for: .normal)
        btn.titleLabel?.font = UIFont.AppleSDGothic(type: .regular, size: 13)
        btn.addTarget(self, action: #selector(touchUpSort(_:)), for: .touchUpInside)

        return btn
    }()

    private let nowPlayingMovie: UIButton = {
        let btn = UIButton()
        btn.tag = filterCase.nowPlaying.rawValue
        btn.setTitle("✓ 현재상영작보기", for: .normal)
        btn.setTitleColor(UIColor.grayTextColor, for: .normal)
        btn.titleLabel?.font = UIFont.AppleSDGothic(type: .regular, size: 13)
        btn.addTarget(self, action: #selector(touchUpSort(_:)), for: .touchUpInside)

        return btn
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

    @objc func touchUpSort(_ sender: UIButton) {
        print("꾹", sender.tag)
    }

    // MARK: - Custom Methods

    func setConstraints() {
        view.addSubviews([segmentControl, tableView])

        segmentControl.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }

        tableView.snp.makeConstraints { make in
            make.top.equalTo(segmentControl.snp.bottom)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalToSuperview()
        }
    }

    func getPopularMovie() {
        movieProvider.request(.getPopular(page: 1)) { response in
            switch response {
            case .success(let result):
                do {
                    let data = try result.map(NetworkResponse.self)
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

extension MoreMovieChartVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        filterHeaderView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        44
    }
}

// MARK: - UITableViewDataSource

extension MoreMovieChartVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movieChartList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieChartTVC.identifier) as? MovieChartTVC else { return UITableViewCell() }
        let movie = movieChartList[indexPath.row]
        cell.setValue(title: movie.title, poster: movie.posterPath, release: movie.releaseDate, isAdult: movie.adult, popularity: movie.popularity.rounded(), voteCount: movie.voteCount, voteAvg: movie.voteAverage)

        return cell
    }
}
