//
//  AnimalTableViewCell.swift
//  SecondQuestion
//
//  Created by Habip Yesilyurt on 20.11.2022.
//

import UIKit

class AnimalTableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var water: UILabel!
    @IBOutlet weak var zookeeper: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    
    @IBAction func soundButtonPressed(_ sender: Any) {
    }
    
    
    @IBAction func editButtonPressed(_ sender: Any) {
    }
    
}
