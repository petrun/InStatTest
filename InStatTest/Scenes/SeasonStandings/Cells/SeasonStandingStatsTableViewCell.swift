//
//  SeasonStandingStatsTableViewCell.swift
//  InStatTest
//
//  Created by andy on 01.07.2022.
//

import UIKit

final class SeasonStandingStatsTableViewCell: UITableViewCell {

    static let id = "SeasonStandingStatsTableViewCell"

    private lazy var statStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Stats:"
        label.font = .boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)

        configureView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        statStack.removeAllArrangedSubviews()
    }

    private func configureView() {
        contentView.addSubview(titleLabel)

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
        ])

        contentView.addSubview(statStack)
        NSLayoutConstraint.activate([
            statStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            statStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            statStack.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            statStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}

extension SeasonStandingStatsTableViewCell: SeasonStandingStatsCellView {
    func display(stats: [SeasonStandingStatsModel]) {
        stats.map { stat in
            let label = UILabel()
            label.text = "\(stat.displayName) \(stat.displayValue)"
            return label
        }.forEach { statStack.addArrangedSubview($0) }
    }
}
