//
//  CharactersView.swift
//  Homework
//
//  Created by Habip Yesilyurt on 27.11.2022.
//

import UIKit

protocol CharactersViewDelegate: AnyObject {
    func showCharacters()
}

final class CharactersView: UIView {
    @IBOutlet weak var characterLabel: UILabel!
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet private weak var characterTextView: UITextView!
    weak var characterDelegate: CharactersViewDelegate?
    
    
    var characters: [String] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        customInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        customInit()
    }
    
    private func customInit() {
        let nib = UINib(nibName: "CharactersView", bundle: nil)
        if let view = nib.instantiate(withOwner: self).first as? UIView {
            addSubview(view)
            view.frame = self.bounds
        }
    }
    
    @IBAction func closeViewPressed(_ sender: Any) {
        //characterDelegate?.showCharacters()
        removeFromSuperview()
    }
    
}
