import SnapKit
import SofaAcademic
import UIKit

class AboutView: BaseView {
    private let titleLabel = UILabel()
    private let classLabel = UILabel()
    private let appNameTitleLabel = UILabel()
    private let appNameLabel = UILabel()
    private let apiCreditTitleLabel = UILabel()
    private let apiCreditLabel = UILabel()
    private let developerTitleLabel = UILabel()
    private let developerLabel = UILabel()
    private let divider = UIView()
    private let logoImageView = UIImageView()

    override func addViews() {
        addSubview(titleLabel)
        addSubview(classLabel)
        addSubview(appNameTitleLabel)
        addSubview(appNameLabel)
        addSubview(apiCreditTitleLabel)
        addSubview(apiCreditLabel)
        addSubview(developerTitleLabel)
        addSubview(developerLabel)
        addSubview(divider)
        addSubview(logoImageView)
    }

    override func styleViews() {
        titleLabel.font = .bold(size: 16)
        titleLabel.textColor = .onSurface1
        titleLabel.text = .about

        classLabel.font = .regular(size: 14)
        classLabel.textColor = .onSurface1

        [appNameTitleLabel, apiCreditTitleLabel, developerTitleLabel].forEach {
            $0.font = .regular(size: 12)
            $0.textColor = .onSurface2
        }

        [appNameLabel, apiCreditLabel, developerLabel].forEach {
            $0.font = .regular(size: 14)
            $0.textColor = .onSurface1
        }

        classLabel.text = .aboutClass
        appNameTitleLabel.text = .aboutAppName
        appNameLabel.text = .aboutAppNameValue
        apiCreditTitleLabel.text = .aboutApiCredit
        apiCreditLabel.text = .aboutApiCreditValue
        developerTitleLabel.text = .aboutDeveloper
        developerLabel.text = .aboutDeveloperValue

        divider.backgroundColor = .onSurface4

        logoImageView.image = UIImage(named: "sofascore_logo")
        logoImageView.contentMode = .scaleAspectFit
    }

    override func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.leading.equalToSuperview().inset(16)
        }

        classLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().inset(16)
        }

        appNameTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(classLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().inset(16)
        }

        appNameLabel.snp.makeConstraints { make in
            make.top.equalTo(appNameTitleLabel.snp.bottom).offset(4)
            make.leading.equalToSuperview().inset(16)
        }

        apiCreditTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(appNameLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().inset(16)
        }

        apiCreditLabel.snp.makeConstraints { make in
            make.top.equalTo(apiCreditTitleLabel.snp.bottom).offset(4)
            make.leading.equalToSuperview().inset(16)
        }

        developerTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(apiCreditLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().inset(16)
        }

        developerLabel.snp.makeConstraints { make in
            make.top.equalTo(developerTitleLabel.snp.bottom).offset(4)
            make.leading.equalToSuperview().inset(16)
        }

        divider.snp.makeConstraints { make in
            make.top.equalTo(developerLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }

        logoImageView.snp.makeConstraints { make in
            make.top.equalTo(divider.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
            make.height.equalTo(40)
            make.bottom.equalToSuperview().inset(16)
        }
    }
}
