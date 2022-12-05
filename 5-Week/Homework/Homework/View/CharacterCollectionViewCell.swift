//
//  CharacterCollectionViewCell.swift
//  Homework
//
//  Created by Habip Yesilyurt on 26.11.2022.
//

import UIKit

class CharacterCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var birthDay: UILabel!
    @IBOutlet weak var nickName: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.borderWidth = 1
        containerView.layer.backgroundColor = UIColor.systemGray3.cgColor
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width - 40).isActive = true
    }
    
    func configureCell(model: CharacterModel) {
        name.text     = model.name
        birthDay.text = model.birthday
        nickName.text = model.nickname
    }

}
