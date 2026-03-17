import SnapKit
import SofaAcademic
import UIKit

class SportSelectorView: BaseView {
    private var sportTabs: [SportTabView] = []
    private let stackView = UIStackView()

    override func addViews() {
        addSubview(stackView)
    }

    override func styleViews() {
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
    }

    override func setupConstraints() {
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
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
    }
    
    private func selectTab(_ selected: SportTabView) {
        sportTabs.forEach { tab in
            tab.setSelected(tab == selected)
        }
    }

    @objc private func tabTapped(_ gesture: UITapGestureRecognizer) {
        guard let tab = gesture.view as? SportTabView else { return }
        selectTab(tab)
    }
}
