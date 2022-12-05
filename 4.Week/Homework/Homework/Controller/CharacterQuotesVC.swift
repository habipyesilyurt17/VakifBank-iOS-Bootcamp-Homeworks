//
//  CharacterQuotesVC.swift
//  Homework
//
//  Created by Habip Yesilyurt on 26.11.2022.
//

import UIKit

class CharacterQuotesVC: BaseVC {
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var quotesTableView: UITableView! {
        didSet {
            quotesTableView.dataSource = self
            quotesTableView.delegate   = self
            quotesTableView.register(UINib(nibName: "CharacterQuotesTableViewCell", bundle: nil), forCellReuseIdentifier: "QuotesCell")
            quotesTableView.estimatedRowHeight = UITableView.automaticDimension
        }
    }
    var selectedAuthor: CharacterModel?

    private var quotes: [QutoeModel]? {
        didSet {
            quotesTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let author = selectedAuthor else { return }
        authorLabel.text = author.name + " Quotes"
        indicator.startAnimating()
        CharacterQuotesManager.shared.getQutoesByAuthor(author: author.name) { [weak self]  quotes, error in
            guard let self = self else { return }
            self.indicator.stopAnimating()
            if let error = error {
                self.showErrorAlert(message: error) {
                    self.navigationController?.popViewController(animated: true)
                }
                return
            }
            if quotes?.isEmpty ?? true {
                self.showErrorAlert(message: "No Quote") {
                    self.navigationController?.popViewController(animated: true)
                }
                return
            }
            self.quotes = quotes
        }
    }
}

extension CharacterQuotesVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        quotes?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "QuotesCell", for: indexPath) as? CharacterQuotesTableViewCell, let model = quotes?[indexPath.row] else { return UITableViewCell() }
        cell.configureCell(model: model)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
}
