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

enum SortCase: Int {
    case popularity = 0
    case vote = 1
}

class MoreMovieChartVC: UIViewController {
    private let movieProvider = MoyaProvider<MovieService>()

    // MARK: - IBOutlets

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self

        tableView.backgroundColor = UIColor.grayViewColor
        tableView.estimatedRowHeight = 120
        tableView.rowHeight = UITableView.automaticDimension

        tableView.register(MovieChartTVC.self, forCellReuseIdentifier: MovieChartTVC.identifier)

        tableView.refreshControl = self.refreshControl

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
        view.addSubviews([popularitySortButton, voteSortButton, nowPlayingMovieButton])

        popularitySortButton.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.leading).inset(10)
            make.centerY.equalTo(view.snp.centerY)
        }

        voteSortButton.snp.makeConstraints { make in
            make.leading.equalTo(popularitySortButton.snp.trailing).inset(-10)
            make.centerY.equalTo(view.snp.centerY)
        }

        nowPlayingMovieButton.snp.makeConstraints { make in
            make.trailing.equalTo(view.snp.trailing).inset(10)
            make.centerY.equalTo(view.snp.centerY)
        }

        return view
    }()

    private let popularitySortButton: UIButton = {
        let btn = UIButton()
        btn.tag = SortCase.popularity.rawValue
        btn.setTitle("• 인기순", for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.titleLabel?.font = UIFont.AppleSDGothic(type: .semiBold, size: 13)
        btn.addTarget(self, action: #selector(changeSortStatus(_:)), for: .touchUpInside)

        return btn
    }()

    private let voteSortButton: UIButton = {
        let btn = UIButton()
        btn.tag = SortCase.vote.rawValue
        btn.setTitle("• 투표율순", for: .normal)
        btn.setTitleColor(UIColor.grayTextColor, for: .normal)
        btn.titleLabel?.font = UIFont.AppleSDGothic(type: .semiBold, size: 13)
        btn.addTarget(self, action: #selector(changeSortStatus(_:)), for: .touchUpInside)

        return btn
    }()

    /// filter 종류가 여러 개면 sort처럼 enum으로 관리하는게 좋을 듯
    private let nowPlayingMovieButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("✓ 현재상영작보기", for: .normal)
        btn.setTitleColor(UIColor.grayTextColor, for: .normal)
        btn.titleLabel?.font = UIFont.AppleSDGothic(type: .semiBold, size: 13)
        btn.addTarget(self, action: #selector(applyFilter(_:)), for: .touchUpInside)

        return btn
    }()

    private let refreshControl: UIRefreshControl = {
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(refreshTableView(_:)), for: .valueChanged)

        return refresh
    }()

    private let nowReservationButton: UIButton = {
        let btn = UIButton(frame: CGRect(origin: .zero, size: CGSize(width: 200, height: 200)))
        btn.setGradient(color1: UIColor(red: 232/255, green: 99/255, blue: 109/255, alpha: 0.85), color2: UIColor(red: 218/255, green: 113/255, blue: 53/255, alpha: 0.85))
        btn.cornerRound(radius: 35)

        btn.addTarget(self, action: #selector(presentReservationVC), for: .touchUpInside)

        return btn
    }()

    private let topButton: UIButton = {
        let btn = UIButton(frame: CGRect(origin: .zero, size: CGSize(width: 60, height: 60)))
        btn.backgroundColor = UIColor(white: 1.0, alpha: 0.9)
        btn.setImage(UIImage(systemName: "arrow.up"), for: .normal)
        btn.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(weight: .heavy), forImageIn: .normal)
        btn.tintColor = UIColor.grayTextColor

        btn.addTarget(self, action: #selector(scrollToTop(_:)), for: .touchUpInside)

        return btn
    }()

    // MARK: - local variable

    private let segmentItems: [String] = [MovieChart.movieChart.rawValue, MovieChart.artHouse.rawValue, MovieChart.upcoming.rawValue]
    private var movieChartList: [Movie] = []
    private var filteredMovieChartList: [Movie] = []
    private var currPage: Int = 1
    private var totalPage: Int = 1
    private var canFetchData: Bool = true

    private var sortButtonStatus: Int = 0 {
        willSet(newValue) {
            switch newValue {
            case 0:
                filterButtonStatus ? filteredMovieChartList.sort { ($0.popularity > $1.popularity) } : movieChartList.sort { ($0.popularity > $1.popularity) }

                popularitySortButton.setTitleColor(UIColor.black, for: .normal)
                voteSortButton.setTitleColor(UIColor.grayTextColor, for: .normal)
            case 1:
                filterButtonStatus ? filteredMovieChartList.sort { ($0.voteCount > $1.voteCount) } : movieChartList.sort { ($0.voteCount > $1.voteCount) }

                popularitySortButton.setTitleColor(UIColor.grayTextColor, for: .normal)
                voteSortButton.setTitleColor(UIColor.black, for: .normal)
            default:
                break
            }

            if sortButtonStatus != newValue {
                tableView.reloadData()
            }
        }
    }

    private var filterButtonStatus: Bool = false {
        didSet {
            tableView.reloadData()
        }

        willSet(newValue) {
            if newValue {
                nowPlayingMovieButton.setTitleColor(UIColor.adultColor, for: .normal)

                filteredMovieChartList = movieChartList.filter {
                    let diff = Calendar.current.dateComponents([.year, .month, .day], from: Date().getStringToDate(date: $0.releaseDate), to: Date())

                    return diff.month ?? 100 <= 1
                }
            } else {
                nowPlayingMovieButton.setTitleColor(UIColor.grayTextColor, for: .normal)
            }
        }
    }

    // MARK: - LifeCycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()

        getMovieDataBySelectedSegmented(selectedIdx: segmentControl.selectedSegmentIndex)
        setConstraints()
        setNavigationBar()
    }

    // MARK: - Action Methods

    @objc func changeSegControl(_ sender: UISegmentedControl) {
        currPage = 1
        totalPage = 1

        // FIXME: - 좀 별로.. 좋지 않은 방식같은
        movieChartList.removeAll()
        tableView.reloadData()

        /// sort, filter  Button 초기화
        sortButtonStatus = 0
        filterButtonStatus = false

        /// filter Button 숨김
        switch sender.selectedSegmentIndex {
        case 2:
            nowPlayingMovieButton.isHidden = true
        default:
            nowPlayingMovieButton.isHidden = false
        }

        getMovieDataBySelectedSegmented(selectedIdx: sender.selectedSegmentIndex)
    }

    @objc func changeSortStatus(_ sender: UIButton) {
        sortButtonStatus = sender.tag
    }

    @objc func applyFilter(_ sender: UIButton) {
        filterButtonStatus.toggle()
    }

    @objc func presentListVC(_ sender: UIBarButtonItem) {
        print("list")
    }

    @objc func refreshTableView(_ sender: UIRefreshControl) {
        movieChartList.removeAll()
        tableView.reloadData()

        currPage = 1
        totalPage = 1

        getMovieDataBySelectedSegmented(selectedIdx: segmentControl.selectedSegmentIndex)
        refreshControl.endRefreshing()
    }

    @objc func presentReservationVC(_ sender: UIButton) {
        let reservationVC = NowReservationVC()
        reservationVC.modalPresentationStyle = .overCurrentContext

        present(reservationVC, animated: true, completion: nil)
    }

    @objc func scrollToTop(_ sender: UIButton) {
        let topIndex = IndexPath(row: 0, section: 0)
        tableView.scrollToRow(at: topIndex, at: .top, animated: true)
    }
}

// MARK: - Custom Methods

extension MoreMovieChartVC {
    func setConstraints() {
        view.addSubviews([segmentControl, tableView, nowReservationButton, topButton])

        segmentControl.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(50)
        }

        tableView.snp.makeConstraints { make in
            make.top.equalTo(segmentControl.snp.bottom)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalToSuperview()
        }

        nowReservationButton.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.45)
            make.height.equalTo(70)
            make.trailing.equalToSuperview().inset(-30)
            make.bottom.equalToSuperview().inset(30)
        }

        topButton.snp.makeConstraints { make in
            make.width.height.equalTo(60)
            make.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(-100)
        }

        topButton.cornerRounds()
        topButton.setShadow(radius: 5, offset: CGSize(width: 3, height: 3), opacity: 0.4)
    }

    func setNavigationBar() {
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.topItem?.title = "영화"

        let listButton = UIBarButtonItem(image: UIImage(systemName: "list.bullet"), style: .plain, target: self, action: #selector(presentListVC(_:)))
        navigationItem.rightBarButtonItem = listButton
    }

    func getMovieDataBySelectedSegmented(selectedIdx: Int) {
        sortButtonStatus = 0
        filterButtonStatus = false

        switch selectedIdx {
        case 0:
            getPopularMovie(page: currPage)
        case 1:
            getTrendMovie(page: currPage)
        case 2:
            getUpcomingMovie(page: currPage)
        default: break
        }
    }
}

// MARK: - Network

extension MoreMovieChartVC {
    func getPopularMovie(page: Int) {
        movieProvider.request(.getPopular(page: page)) { response in
            switch response {
            case .success(let result):
                do {
                    let data = try result.map(NetworkResponse.self)

                    self.movieChartList.append(contentsOf: data.results)
                    self.totalPage = data.totalPages
                    self.canFetchData = true

                    self.tableView.reloadData()
                } catch {
                    print(self.currPage)
                    print(self.totalPage)
                    print("parsing error")
                }
            case .failure(let err):
                print(err)
            }
        }
    }

    func getTrendMovie(page: Int) {
        movieProvider.request(.getTrend(page: page)) { response in
            switch response {
            case .success(let result):
                do {
                    let data = try result.map(NetworkResponse.self)

                    self.movieChartList.append(contentsOf: data.results)
                    self.totalPage = data.totalPages
                    self.canFetchData = true

                    self.tableView.reloadData()
                } catch {
                    print("parsing error")
                }
            case .failure(let err):
                print(err)
            }
        }
    }

    func getUpcomingMovie(page: Int) {
        movieProvider.request(.getUpcoming(page: page)) { response in
            switch response {
            case .success(let result):
                do {
                    let data = try result.map(NetworkResponse.self)

                    self.movieChartList.append(contentsOf: data.results)
                    self.totalPage = data.totalPages
                    self.canFetchData = true

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

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > scrollView.contentSize.height - scrollView.bounds.size.height {
            if canFetchData, currPage < totalPage {
                currPage += 1
                canFetchData = false
                getMovieDataBySelectedSegmented(selectedIdx: segmentControl.selectedSegmentIndex)
            }
        }

        if scrollView.contentOffset.y > 10 {
            topButton.isHidden = false

            topButton.snp.updateConstraints { make in
                make.bottom.equalToSuperview().inset(30)
            }

            nowReservationButton.snp.updateConstraints { make in
                make.bottom.equalToSuperview().inset(45 + self.topButton.bounds.height)
            }

        } else {
            topButton.isHidden = true

            topButton.snp.updateConstraints { make in
                make.bottom.equalToSuperview().inset(-100)
            }

            nowReservationButton.snp.updateConstraints { make in
                make.bottom.equalToSuperview().inset(30)
            }
        }

        /// top button animation
        UIView.animate(withDuration: 0.8) {
            self.view.layoutIfNeeded()
        }
    }
}

// MARK: - UITableViewDataSource

extension MoreMovieChartVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filterButtonStatus ? filteredMovieChartList.count : movieChartList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieChartTVC.identifier) as? MovieChartTVC else { return UITableViewCell() }
        let movie = filterButtonStatus ? filteredMovieChartList[indexPath.row] : movieChartList[indexPath.row]
        cell.setValue(title: movie.title, poster: movie.posterPath, release: movie.releaseDate, isAdult: movie.adult, popularity: movie.popularity.rounded(), voteCount: movie.voteCount, voteAvg: movie.voteAverage)

        cell.separatorInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        return cell
    }
}
