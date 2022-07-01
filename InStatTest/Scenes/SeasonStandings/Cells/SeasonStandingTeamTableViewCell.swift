//
//  SeasonStandingTeamTableViewCell.swift
//  InStatTest
//
//  Created by andy on 01.07.2022.
//

import UIKit

final class SeasonStandingTeamTableViewCell: UITableViewCell {

    static let id = "SeasonStandingTeamTableViewCell"

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        return label
    }()

    private lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14)
        return label
    }()

    private lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "goforward")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)

        configureView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        titleLabel.text = nil
        locationLabel.text = nil
        logoImageView.cancelImageLoad()
        logoImageView.image = UIImage(systemName: "goforward")
    }

    private func configureView() {
        addSubview(logoImageView)
        addSubview(titleLabel)
        addSubview(locationLabel)

        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            logoImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            logoImageView.bottomAnchor.constraint(lessThanOrEqualTo: safeAreaLayoutGuide.bottomAnchor, constant: -10),
            logoImageView.heightAnchor.constraint(equalToConstant: 60),
            logoImageView.widthAnchor.constraint(equalToConstant: 60)
        ])

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: logoImageView.leadingAnchor, constant: -10),
        ])

        NSLayoutConstraint.activate([
            locationLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            locationLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            locationLabel.trailingAnchor.constraint(lessThanOrEqualTo: logoImageView.leadingAnchor, constant: -10),
            locationLabel.bottomAnchor.constraint(lessThanOrEqualTo: safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
    }
}

extension SeasonStandingTeamTableViewCell: SeasonStandingTeamCellView {
    func display(team: SeasonStandingTeamCellObject) {
        titleLabel.text = team.displayName
        locationLabel.text = team.location

        if let logoURL = team.logoURL {
            logoImageView.loadImage(at: URL(string: logoURL)!)
        }
    }
}
