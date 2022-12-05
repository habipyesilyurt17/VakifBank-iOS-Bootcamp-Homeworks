//
//  ChapterListVC.swift
//  Homework
//
//  Created by Habip Yesilyurt on 25.11.2022.
//

import UIKit

final class EpisodeListVC: UIViewController {
    @IBOutlet private weak var seasonLabel: UILabel!
    @IBOutlet private weak var episodeTableView: UITableView!

    var episodes: [SeasonModel]?
    var season: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        seasonLabel.text = (season ?? "") + ". Season"
        configureEpisodeTableView()
    }
    
    private func configureEpisodeTableView() {
        episodeTableView.dataSource = self
        episodeTableView.delegate   = self
        episodeTableView.register(UINib(nibName: "EpisodeTableViewCell", bundle: nil), forCellReuseIdentifier: "EpisodeCell")
    }
    
}

extension EpisodeListVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        episodes?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EpisodeCell", for: indexPath) as? EpisodeTableViewCell, let model = episodes?[indexPath.row] else { return UITableViewCell() }
        cell.configureCell(model: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //charactersView.characters = episodes![indexPath.row].characters
        let charactersView = CharactersView(frame: CGRect(origin: CGPoint(x: view.center.x - 100, y: view.center.y - 100), size: CGSize(width: 200, height: 200)))
        charactersView.alpha = 0
        UIView.animate(withDuration: 2.0) {
            charactersView.alpha = 1
        }
        //charactersView.delegate = self
        view.addSubview(charactersView)
    }
    
}
