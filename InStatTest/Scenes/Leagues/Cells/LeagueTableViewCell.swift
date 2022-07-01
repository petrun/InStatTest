//
//  LeagueTableViewCell.swift
//  InStatTest
//
//  Created by andy on 30.06.2022.
//

import UIKit

final class LeagueTableViewCell: UITableViewCell {

    static let id = "LeagueTableViewCell"

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        return label
    }()

    private lazy var abbrLabel: UILabel = {
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
        abbrLabel.text = nil
        logoImageView.cancelImageLoad()
        logoImageView.image = UIImage(systemName: "goforward")
    }

    private func configureView() {
        addSubview(logoImageView)
        addSubview(titleLabel)
        addSubview(abbrLabel)

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
            abbrLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            abbrLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            abbrLabel.trailingAnchor.constraint(lessThanOrEqualTo: logoImageView.leadingAnchor, constant: -10),
            abbrLabel.bottomAnchor.constraint(lessThanOrEqualTo: safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
    }
}

extension LeagueTableViewCell: LeaguesCellView {
    func display(title: String) {
        titleLabel.text = title
    }

    func display(abbr: String) {
        abbrLabel.text = abbr
    }

    func display(logoURL: String) {
        logoImageView.loadImage(at: URL(string: logoURL)!)
    }
}
