import SnapKit
import SofaAcademic
import UIKit

class LeagueDetailsViewController: UIViewController, BaseViewProtocol {
    private let safeAreaBackgroundView = UIView()
    private let headerView = LeagueHeaderDetailView()
    private let leagueSelectorView = LeagueSelectorView()
    private let matchesView = UIView()
    private let standingsView = UIView()

    private let league: League
    private let sport: Sport
    private var selectedTab: LeagueTab = .matches

    init(league: League, sport: Sport) {
        self.league = league
        self.sport = sport
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
        styleViews()
        setupConstraints()
        setupBinding()
        loadData()
        selectTab(.matches)
    }

    func addViews() {
        view.addSubview(safeAreaBackgroundView)
        view.addSubview(headerView)
        view.addSubview(leagueSelectorView)
        view.addSubview(matchesView)
        view.addSubview(standingsView)
    }

    func styleViews() {
        view.backgroundColor = .systemBackground
        safeAreaBackgroundView.backgroundColor = .primaryDefault
    }

    func setupConstraints() {
        safeAreaBackgroundView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.top)
        }

        headerView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
        }

        leagueSelectorView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }

        matchesView.snp.makeConstraints { make in
            make.top.equalTo(leagueSelectorView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }

        standingsView.snp.makeConstraints { make in
            make.top.equalTo(leagueSelectorView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }

    private func setupBinding() {
        leagueSelectorView.onTabSelected = { [weak self] tab in
            self?.selectTab(tab)
        }

        headerView.onBackTapped = { [weak self] in
            self?.navigationController?.popViewController(animated: false)
        }
    }

    private func loadData() {
        let detailsViewModel = LeagueDetailsViewModel(
            league: league,
            sport: sport
        )
        headerView.configure(with: LeagueHeaderDetailViewModel(league: league))

        Task { @MainActor [weak self] in
            guard let self else { return }
            let headerViewModel = await detailsViewModel.fetchHeaderViewModel()
            self.headerView.configure(with: headerViewModel)
        }
    }

    private func selectTab(_ tab: LeagueTab) {
        selectedTab = tab
        leagueSelectorView.selectTab(tab)
        matchesView.isHidden = tab != .matches
        standingsView.isHidden = tab != .standings
    }
}
