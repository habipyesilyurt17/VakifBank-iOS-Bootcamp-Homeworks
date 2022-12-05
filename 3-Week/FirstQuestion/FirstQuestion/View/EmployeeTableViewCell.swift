//
//  EmployeeTableViewCell.swift
//  FirstQuestion
//
//  Created by Habip Yesilyurt on 20.11.2022.
//

import UIKit

class EmployeeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var age: UILabel!
    @IBOutlet weak var maritalStatus: UILabel!
    @IBOutlet weak var workPosition: UILabel!
    @IBOutlet weak var salary: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
