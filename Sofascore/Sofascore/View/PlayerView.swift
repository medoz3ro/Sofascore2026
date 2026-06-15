import Kingfisher
import SnapKit
import SofaAcademic
import UIKit

class PlayerView: BaseView {
    private let playerImageView = UIImageView()
    private let nameLabel = UILabel()
    private let countryFlagImageView = UIImageView()
    private let countryNameLabel = UILabel()

    override func addViews() {
        addSubview(playerImageView)
        addSubview(nameLabel)
        addSubview(countryFlagImageView)
        addSubview(countryNameLabel)
    }

    override func styleViews() {
        backgroundColor = .systemBackground

        playerImageView.contentMode = .scaleAspectFit
        playerImageView.layer.cornerRadius = 20
        playerImageView.clipsToBounds = true

        nameLabel.font = .regular(size: 14)
        nameLabel.textColor = .onSurface1
        nameLabel.numberOfLines = 1

        countryFlagImageView.contentMode = .scaleAspectFit

        countryNameLabel.font = .regular(size: 12)
        countryNameLabel.textColor = .onSurface2
        countryNameLabel.numberOfLines = 1
    }

    override func setupConstraints() {
        playerImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.top.bottom.equalToSuperview().inset(8)
            make.size.equalTo(40)
        }

        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(playerImageView.snp.trailing).offset(16)
            make.top.equalTo(playerImageView)
            make.trailing.equalToSuperview().inset(16)
        }

        countryFlagImageView.snp.makeConstraints { make in
            make.leading.equalTo(nameLabel)
            make.top.equalTo(nameLabel.snp.bottom).offset(4)
            make.size.equalTo(16)
        }

        countryNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(countryFlagImageView.snp.trailing).offset(4)
            make.centerY.equalTo(countryFlagImageView)
        }
    }

    func configure(with viewModel: PlayerViewModel) {
        playerImageView.kf.setImage(with: URL(string: viewModel.imageUrl ?? ""))
        nameLabel.text = viewModel.name
        countryNameLabel.text = viewModel.countryName
        countryFlagImageView.kf.setImage(
            with: URL(string: viewModel.flagUrl ?? "")
        )
    }
}
