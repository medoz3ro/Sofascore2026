import UIKit
import SnapKit
import SofaAcademic

class LeagueView: BaseView {
    private let nameLabel: UILabel = UILabel()
    private let countryLabel: UILabel = UILabel()
    private let logoImage: UIImageView = UIImageView()
    private let pointerImage: UIImageView = UIImageView()
    
    override func addViews() {
        addSubview(logoImage)
        addSubview(countryLabel)
        addSubview(pointerImage)
        addSubview(nameLabel)
    }
    
    override func styleViews() {
        countryLabel.textColor = .onSurfaceLv1
        countryLabel.font = .bold(size: 14)
        
        nameLabel.textColor = .onSurfaceLv2
        nameLabel.font = .regular(size: 14)
        
        pointerImage.image = UIImage(named: "pointer_right")?.withRenderingMode(.alwaysTemplate)
        pointerImage.tintColor = .onSurfaceLv2
    }
    
    override func setupConstraints() {
        logoImage.snp.makeConstraints { make in
            make.size.equalTo(32)
            make.leading.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
        }
        
        countryLabel.snp.makeConstraints { make in
            make.leading.equalTo(logoImage.snp.trailing).offset(32)
            make.centerY.equalToSuperview()
        }
        
        pointerImage.snp.makeConstraints { make in
            make.leading.equalTo(countryLabel.snp.trailing)
            make.centerY.equalToSuperview()
            make.size.equalTo(24)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(pointerImage.snp.trailing)
            make.centerY.equalToSuperview()
        }
    }
    
    func configure(with viewModel: LeagueViewModel) {
        nameLabel.text = viewModel.name
        countryLabel.text = viewModel.country
        logoImage.image = viewModel.logo
    }
}
