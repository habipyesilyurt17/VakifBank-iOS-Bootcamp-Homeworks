//
//  CharacterListVC.swift
//  Homework
//
//  Created by Habip Yesilyurt on 25.11.2022.
//

import UIKit

class CharacterListVC: BaseVC {
    @IBOutlet weak var charactersCollectionView: UICollectionView!
    
    private var characters: [CharacterModel]? {
        didSet {
            charactersCollectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCharactersCollectionView()
        indicator.startAnimating()
        CharacterManager.shared.getCharacters { [weak self] characters, error in
            guard let self = self else { return }
            self.indicator.stopAnimating()
            self.characters = characters
        }
    }
    
    private func configureCharactersCollectionView() {
        charactersCollectionView.dataSource = self
        charactersCollectionView.delegate   = self
        charactersCollectionView.register(UINib(nibName: "CharacterCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CharacterCell")
        
        if let collectionViewLayout = charactersCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            collectionViewLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }

    
}

extension CharacterListVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        characters?.count ?? 0
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CharacterCell", for: indexPath) as? CharacterCollectionViewCell, let model = characters?[indexPath.row] else { return UICollectionViewCell() }
        cell.configureCell(model: model)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let characterDetailVC = storyboard?.instantiateViewController(withIdentifier: "CharacterDetailVC") as? CharacterDetailVC, let choosenCharacter = characters?[indexPath.row] else { return }
        characterDetailVC.selectedCharacter = choosenCharacter
        navigationController?.pushViewController(characterDetailVC, animated: true)
    }
}
