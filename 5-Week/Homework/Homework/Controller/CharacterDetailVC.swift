//
//  CharacterDetailVC.swift
//  Homework
//
//  Created by Habip Yesilyurt on 26.11.2022.
//

import UIKit
import Kingfisher

final class CharacterDetailVC: BaseVC {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var nickName: UILabel!
    @IBOutlet weak var portrayed: UILabel!
    @IBOutlet weak var birthday: UILabel!
    
    var selectedCharacter: CharacterModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let character = selectedCharacter else { return }
        let url = URL(string: character.img)
        imageView.kf.setImage(with: url)
        name.attributedText      = boldText(boldText: "Name: ", normalText: character.name)
        nickName.attributedText  = boldText(boldText: "Nickname: ", normalText: character.nickname)
        portrayed.attributedText = boldText(boldText: "Portrayed: ", normalText: character.portrayed)
        birthday.attributedText  = boldText(boldText: "Birthday: ", normalText: character.birthday)
    }
    
    
    private func boldText(boldText: String, normalText: String) -> NSMutableAttributedString {
        let attrs      = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 16)]
        let boldString = NSMutableAttributedString(string: boldText, attributes: attrs)
        let attributedString = NSMutableAttributedString(string: normalText)
        let result = NSMutableAttributedString()
        result.append(boldString)
        result.append(attributedString)
        return result
    }
    
    
    @IBAction func getAllQuotesButtonPressed(_ sender: Any) {
        guard let characterQutoesVC = storyboard?.instantiateViewController(withIdentifier: "CharacterQuotesVC") as? CharacterQuotesVC, let choosenAuthor = selectedCharacter  else { return }
        characterQutoesVC.selectedAuthor = choosenAuthor
        navigationController?.pushViewController(characterQutoesVC, animated: true)
    }
    
}
