//
//  EpisodeTableViewCell.swift
//  Homework
//
//  Created by Habip Yesilyurt on 27.11.2022.
//

import UIKit

final class EpisodeTableViewCell: UITableViewCell {
    @IBOutlet weak var episodeLabel: UILabel!
    @IBOutlet weak var episodeTitle: UILabel!
    
    func configureCell(model: SeasonModel) {
        episodeLabel.text = model.episode + ". episode"
        episodeTitle.text = model.title
    }
}
