import SnapKit
import SofaAcademic
import UIKit

class TeamSelectorView: BaseView {
    var onTabSelected: ((TeamTab) -> Void)?

    private let detailsTab = LeagueTabView()
    private let playersTab = LeagueTabView()
    private let stackView = UIStackView()
    private let selectionIndicator = UIView()
    private var isInitialized = false

    override func addViews() {
        addSubview(stackView)
        addSubview(selectionIndicator)
        stackView.addArrangedSubview(detailsTab)
        stackView.addArrangedSubview(playersTab)
    }

    override func styleViews() {
        backgroundColor = .primaryDefault

        stackView.axis = .horizontal
        stackView.distribution = .fillEqually

        selectionIndicator.backgroundColor = .white

        detailsTab.configure(with: .details)
        playersTab.configure(with: .players)

        detailsTab.addGestureRecognizer(
            UITapGestureRecognizer(
                target: self,
                action: #selector(detailsTapped)
            )
        )
        playersTab.addGestureRecognizer(
            UITapGestureRecognizer(
                target: self,
                action: #selector(playersTapped)
            )
        )
    }

    override func setupConstraints() {
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        selectionIndicator.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.height.equalTo(4)
            make.width.equalTo(164)
            make.centerX.equalTo(detailsTab)
        }
    }

    func selectTab(_ tab: TeamTab) {
        let targetTab = tab == .details ? detailsTab : playersTab
        selectionIndicator.snp.remakeConstraints { make in
            make.bottom.equalToSuperview()
            make.height.equalTo(4)
            make.width.equalTo(164)
            make.centerX.equalTo(targetTab)
        }
        if isInitialized {
            UIView.animate(withDuration: 0.3) {
                self.layoutIfNeeded()
            }
        } else {
            layoutIfNeeded()
            isInitialized = true
        }
    }

    @objc private func detailsTapped() {
        selectTab(.details)
        onTabSelected?(.details)
    }

    @objc private func playersTapped() {
        selectTab(.players)
        onTabSelected?(.players)
    }
}
