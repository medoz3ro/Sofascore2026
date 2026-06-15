import SnapKit
import SofaAcademic
import UIKit

class TeamDetailsViewController: UIViewController, BaseViewProtocol {
    private let safeAreaBackgroundView = UIView()
    private let headerView = TeamHeaderView()
    private let teamSelectorView = TeamSelectorView()
    private let detailsView = UIView()
    private let playersView = UIView()

    private let teamId: Int
    private var selectedTab: TeamTab = .details

    init(teamId: Int) {
        self.teamId = teamId
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) { fatalError() }

    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
        styleViews()
        setupConstraints()
        setupBinding()
        loadData()
        selectTab(.details)
    }

    func addViews() {
        view.addSubview(safeAreaBackgroundView)
        view.addSubview(headerView)
        view.addSubview(teamSelectorView)
        view.addSubview(detailsView)
        view.addSubview(playersView)
    }

    func styleViews() {
        view.backgroundColor = .onSurface0
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

        teamSelectorView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }

        detailsView.snp.makeConstraints { make in
            make.top.equalTo(teamSelectorView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }

        playersView.snp.makeConstraints { make in
            make.top.equalTo(teamSelectorView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }

    private func setupBinding() {
        teamSelectorView.onTabSelected = { [weak self] tab in
            self?.selectTab(tab)
        }

        headerView.onBackTapped = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
    }

    private func loadData() {
        let viewModel = TeamDetailsViewModel(teamId: teamId)

        Task { @MainActor [weak self] in
            guard let self else { return }
            do {
                let teamInfo = try await viewModel.fetchTeamInfo()
                self.headerView.configure(
                    with: TeamHeaderViewModel(teamInfo: teamInfo)
                )
            } catch {
                print("Error fetching team info: \(error)")
            }
        }

        Task { @MainActor [weak self] in
            guard let self else { return }
            do {
                let teamInfo = try await viewModel.fetchTeamInfo()
                var headerViewModel = TeamHeaderViewModel(teamInfo: teamInfo)
                self.headerView.configure(with: headerViewModel)
                let flagUrl = try await APIClient.fetchCountryFlag(
                    countryName: teamInfo.team.country?.name ?? ""
                )
                headerViewModel.flagUrl = flagUrl
                self.headerView.configure(with: headerViewModel)
            } catch {
                print("Error fetching team info: \(error)")
            }
        }
    }

    private func selectTab(_ tab: TeamTab) {
        selectedTab = tab
        teamSelectorView.selectTab(tab)
        detailsView.isHidden = tab != .details
        playersView.isHidden = tab != .players
    }
}
