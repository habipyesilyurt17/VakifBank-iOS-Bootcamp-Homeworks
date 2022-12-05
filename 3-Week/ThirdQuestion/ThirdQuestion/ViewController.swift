//
//  ViewController.swift
//  ThirdQuestion
//
//  Created by Habip Yesilyurt on 20.11.2022.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var quoteLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureQuoteLabel()
        
        let randomCount = Int.random(in: 1..<100)
        let randomIndex = Int.random(in: 0..<randomCount)
        getQuotes(count: randomCount, index: randomIndex) { errorMessage in
            if let errorMessage = errorMessage {
                print("error: \(errorMessage)")
            }
        }
    }
    
    
    private func configureQuoteLabel() {
        quoteLabel.numberOfLines = 0
        quoteLabel.adjustsFontSizeToFitWidth = false
        quoteLabel.lineBreakMode = .byTruncatingTail
        quoteLabel.font = .boldSystemFont(ofSize: 14)
    }

    @IBAction func changeButtonPressed(_ sender: Any) {
        let randomCount = Int.random(in: 1..<100)
        let randomIndex = Int.random(in: 0..<randomCount)

        getQuotes(count: randomCount, index: randomIndex) { errorMessage in
            if let errorMessage = errorMessage {
                print("error: \(errorMessage)")
            }
        }
    }
    
    func getQuotes(count: Int, index: Int, completion: @escaping ((String?) -> ())) {
        QuotesManager.shared.getQuotes(count: count, index: index) { quotes, errorMessage in
            if let quotes = quotes {
                DispatchQueue.main.async {
                    self.quoteLabel.text = quotes[index].en
                }
            }
            completion(errorMessage ?? "")
        }
    }
    
    
}

