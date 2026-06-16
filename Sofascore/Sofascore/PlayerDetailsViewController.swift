import Kingfisher
import SnapKit
import SofaAcademic
import UIKit

class PlayerDetailsViewController: UIViewController, BaseViewProtocol {
    private let safeAreaBackgroundView = UIView()
    private let headerView = DetailHeaderView()
    private let teamView = UIView()
    private let teamLogoImageView = UIImageView()
    private let teamNameLabel = UILabel()
    private let statsStackView = UIStackView()
    private let nationalityStatView = StatView()
    private let positionStatView = StatView()
    private let jerseyStatView = StatView()

    private let viewModel: PlayerDetailsViewModel

    init(viewModel: PlayerDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) { fatalError() }

    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
        styleViews()
        setupConstraints()
        setupBinding()
        configure()
    }

    func addViews() {
        view.addSubview(safeAreaBackgroundView)
        view.addSubview(headerView)
        view.addSubview(teamView)
        teamView.addSubview(teamLogoImageView)
        teamView.addSubview(teamNameLabel)
        view.addSubview(statsStackView)
        statsStackView.addArrangedSubview(nationalityStatView)
        statsStackView.addArrangedSubview(positionStatView)
        statsStackView.addArrangedSubview(jerseyStatView)
    }

    func styleViews() {
        view.backgroundColor = .systemBackground
        safeAreaBackgroundView.backgroundColor = .primaryDefault

        teamView.backgroundColor = .systemBackground

        teamLogoImageView.contentMode = .scaleAspectFit

        teamNameLabel.font = .regular(size: 14)
        teamNameLabel.textColor = .onSurface1

        statsStackView.axis = .horizontal
        statsStackView.distribution = .fillEqually
        statsStackView.spacing = 0
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

        teamView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(56)
        }

        teamLogoImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
            make.size.equalTo(40)
        }

        teamNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(teamLogoImageView.snp.trailing).offset(6)
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(16)
        }

        statsStackView.snp.makeConstraints { make in
            make.top.equalTo(teamView.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }
    }

    private func setupBinding() {
        headerView.onBackTapped = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
    }

    private func configure() {
        let headerViewModel = DetailHeaderViewModel(
            title: viewModel.name,
            subtitle: "",
            logoUrl: viewModel.imageUrl
        )
        headerView.configure(with: headerViewModel)

        teamLogoImageView.kf.setImage(
            with: URL(string: viewModel.teamLogoUrl ?? "")
        )
        teamNameLabel.text = viewModel.teamName

        nationalityStatView.configure(
            with: StatViewModel(
                title: .nationality,
                value: viewModel.nationality,
                type: .flag(url: viewModel.nationalityFlag ?? "")
            )
        )
        positionStatView.configure(
            with: StatViewModel(
                title: .position,
                value: viewModel.position,
                type: .text
            )
        )
        jerseyStatView.configure(
            with: StatViewModel(
                title: .jersey,
                value: viewModel.jerseyNumber,
                type: .icon(
                    image: UIImage(named: "jersey_icon") ?? UIImage(),
                    textColor: .white
                )
            )
        )
    }
}
