//
//  CharacterQuotesTableViewCell.swift
//  Homework
//
//  Created by Habip Yesilyurt on 26.11.2022.
//

import UIKit

final class CharacterQuotesTableViewCell: UITableViewCell {
    @IBOutlet private weak var quoteLabel: UILabel!

    func configureCell(model: QutoeModel) {
        quoteLabel.text = String(model.quote)
    }
    
}
