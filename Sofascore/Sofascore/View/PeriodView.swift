import SnapKit
import SofaAcademic
import UIKit

class PeriodView: BaseView {
    private let containerView = UIView()
    private let periodLabel = UILabel()

    override func addViews() {
        addSubview(containerView)
        containerView.addSubview(periodLabel)
    }

    override func styleViews() {
        backgroundColor = .systemBackground

        containerView.backgroundColor = .onSurface4
        containerView.layer.cornerRadius = 12

        periodLabel.font = .bold(size: 12)
        periodLabel.textColor = .onSurface1
        periodLabel.textAlignment = .center
        periodLabel.numberOfLines = 1
    }

    override func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.top.bottom.equalToSuperview().inset(8)
            make.leading.trailing.greaterThanOrEqualToSuperview().inset(16)
        }

        periodLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(
                UIEdgeInsets(top: 4, left: 12, bottom: 4, right: 12)
            )
            make.height.equalTo(16)
        }
    }

    func configure(with viewModel: PeriodViewModel) {
        periodLabel.text = viewModel.title
        periodLabel.textColor = viewModel.isLive ? .liveRed : .onSurface1
    }
}
