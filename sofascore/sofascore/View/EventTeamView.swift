import SnapKit
import SofaAcademic
import UIKit

class EventTeamView: BaseView {
    private let logoImageView = UIImageView()
    private let nameLabel = UILabel()

    override func addViews() {
        addSubview(logoImageView)
        addSubview(nameLabel)
    }

    override func styleViews() {
        logoImageView.contentMode = .scaleAspectFit

        nameLabel.font = .bold(size: 12)
        nameLabel.textColor = .onSurfaceLv1
        nameLabel.textAlignment = .center
        nameLabel.numberOfLines = 2
    }

    override func setupConstraints() {
        logoImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(28)
            make.size.equalTo(40)
        }

        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(32)
        }
    }

    func configure(with viewModel: EventTeamViewModel) {
        logoImageView.image = viewModel.logo
        nameLabel.text = viewModel.name
    }
}
