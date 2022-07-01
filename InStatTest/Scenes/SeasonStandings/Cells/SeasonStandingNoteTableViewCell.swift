//
//  SeasonStandingNoteTableViewCell.swift
//  InStatTest
//
//  Created by andy on 01.07.2022.
//

import UIKit

final class SeasonStandingNoteTableViewCell: UITableViewCell {

    static let id = "SeasonStandingNoteTableViewCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        textLabel?.text = nil
        detailTextLabel?.text = nil
        imageView?.image = nil
        imageView?.cancelImageLoad()
    }
}

extension SeasonStandingNoteTableViewCell: SeasonStandingNoteCellView {
    func display(note: SeasonStandingNoteModel) {
        textLabel?.text = note.description
    }
}
