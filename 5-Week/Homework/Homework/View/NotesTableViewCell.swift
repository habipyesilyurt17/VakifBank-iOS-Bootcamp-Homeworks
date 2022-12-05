//
//  NotesTableViewCell.swift
//  Homework
//
//  Created by Halil Yeşilyurt on 4.12.2022.
//

import UIKit

final class NotesTableViewCell: UITableViewCell {
    @IBOutlet weak var seasonLabel: UILabel!
    @IBOutlet weak var episodeLabel: UILabel!
    @IBOutlet weak var noteLabel: UILabel!
    
    
    func configureCell(model: Notes) {
        seasonLabel.text = (model.season ?? "") + ".Season"
        episodeLabel.text = model.episode
        noteLabel.text = model.note
    }

}
