import SnapKit
import SofaAcademic
import UIKit

class SportSelectorView: BaseView {
    var onSportSelected: ((Int) -> Void)?
    private var sportTabs: [SportTabView] = []
    private let stackView = UIStackView()
    private let selectionIndicator = UIView()

    override func addViews() {
        addSubview(stackView)
        addSubview(selectionIndicator)
    }

    override func styleViews() {
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually

        selectionIndicator.backgroundColor = .white
    }

    override func setupConstraints() {
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func moveIndicator(to tab: SportTabView) {
        selectionIndicator.snp.remakeConstraints { make in
            make.width.equalTo(102)
            make.height.equalTo(4)
            make.bottom.equalToSuperview()
            make.centerX.equalTo(tab)
        }
    }

    func configure(with viewModel: SportSelectorViewModel) {
        viewModel.sports.forEach { sport in
            let tab = SportTabView()
            tab.configure(with: sport)
            tab.addGestureRecognizer(
                UITapGestureRecognizer(
                    target: self,
                    action: #selector(tabTapped(_:))
                )
            )
            stackView.addArrangedSubview(tab)
            sportTabs.append(tab)
        }

        if let firstTab = sportTabs.first {
            moveIndicator(to: firstTab)
        }
    }

    private func selectTab(_ selected: SportTabView) {
        UIView.animate(withDuration: 0.3) {
            self.moveIndicator(to: selected)
            self.layoutIfNeeded()
        }
    }

    @objc private func tabTapped(_ gesture: UITapGestureRecognizer) {
        guard let tab = gesture.view as? SportTabView else { return }
        selectTab(tab)
        if let index = sportTabs.firstIndex(of: tab) {
            onSportSelected?(index)
        }
    }
}
