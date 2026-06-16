import SnapKit
import SofaAcademic
import UIKit

class IncidentCell: UICollectionViewCell, BaseViewProtocol {
    private let incidentView = IncidentView()
    private let goalIncidentView = GoalIncidentView()
    private let basketballIncidentView = BasketballIncidentView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) { fatalError() }

    func addViews() {
        contentView.addSubview(incidentView)
        contentView.addSubview(goalIncidentView)
        contentView.addSubview(basketballIncidentView)
    }

    func styleViews() {
    }

    func setupConstraints() {
        incidentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        goalIncidentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        basketballIncidentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    func configure(with viewModel: IncidentViewModel) {
        incidentView.isHidden = true
        goalIncidentView.isHidden = true
        basketballIncidentView.isHidden = true

        if viewModel.isBasketball && viewModel.isGoal {
            basketballIncidentView.isHidden = false
            basketballIncidentView.configure(with: viewModel)
        } else if viewModel.isGoal {
            goalIncidentView.isHidden = false
            goalIncidentView.configure(with: viewModel)
        } else {
            incidentView.isHidden = false
            incidentView.configure(with: viewModel)
        }
    }
}
