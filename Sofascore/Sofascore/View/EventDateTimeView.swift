import SnapKit
import SofaAcademic
import UIKit

class EventDateTimeView: BaseView {
    private let dateLabel = UILabel()
    private let timeLabel = UILabel()

    override func addViews() {
        addSubview(dateLabel)
        addSubview(timeLabel)
    }

    override func styleViews() {
        dateLabel.font = .regular(size: 12)
        dateLabel.textColor = .onSurfaceLv1
        dateLabel.textAlignment = .center

        timeLabel.font = .regular(size: 12)
        timeLabel.textColor = .onSurfaceLv1
        timeLabel.textAlignment = .center
    }

    override func setupConstraints() {
        dateLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(16)
        }

        timeLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(40)
        }
    }

    func configure(with viewModel: EventDateTimeViewModel) {
        dateLabel.text = viewModel.date
        timeLabel.text = viewModel.time
    }
}
