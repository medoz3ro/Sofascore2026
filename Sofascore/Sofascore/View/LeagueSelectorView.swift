import SnapKit
import SofaAcademic
import UIKit

class LeagueSelectorView: BaseView {
    var onTabSelected: ((LeagueTab) -> Void)?

    private let matchesTab = LeagueTabView()
    private let standingsTab = LeagueTabView()
    private let stackView = UIStackView()
    private let selectionIndicator = UIView()
    private var isInitialized = false

    override func addViews() {
        addSubview(stackView)
        addSubview(selectionIndicator)
        stackView.addArrangedSubview(matchesTab)
        stackView.addArrangedSubview(standingsTab)
    }

    override func styleViews() {
        backgroundColor = .primaryDefault

        stackView.axis = .horizontal
        stackView.distribution = .fillEqually

        selectionIndicator.backgroundColor = .white

        matchesTab.configure(with: .matches)
        standingsTab.configure(with: .standings)

        matchesTab.addGestureRecognizer(
            UITapGestureRecognizer(
                target: self,
                action: #selector(matchesTapped)
            )
        )
        standingsTab.addGestureRecognizer(
            UITapGestureRecognizer(
                target: self,
                action: #selector(standingsTapped)
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
            make.centerX.equalTo(matchesTab)
        }
    }

    func selectTab(_ tab: LeagueTab) {
        let targetTab = tab == .matches ? matchesTab : standingsTab
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

    @objc private func matchesTapped() {
        selectTab(.matches)
        onTabSelected?(.matches)
    }

    @objc private func standingsTapped() {
        selectTab(.standings)
        onTabSelected?(.standings)
    }
}
