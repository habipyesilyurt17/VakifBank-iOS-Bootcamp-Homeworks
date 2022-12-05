//
//  SeasonListVC.swift
//  Homework
//
//  Created by Habip Yesilyurt on 27.11.2022.
//

import UIKit

final class SeasonListVC: BaseVC {
    @IBOutlet weak var seasonTableView: UITableView!
       
    private var seriesDatas: [SeasonModel]? {
        didSet {
            guard let datas = seriesDatas else { return }
            let seasonArr = datas.map { $0.season.trimmingCharacters(in: .whitespaces) }
            seasons = Set(seasonArr).sorted(by: <)
        }
    }
    
    private var seasons: [String]? {
        didSet {
            seasonTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSeasonTableView()
        indicator.startAnimating()
        EpisodeManager.shared.getEpisodes { [weak self] datas, error in
            guard let self = self else { return }
            self.indicator.stopAnimating()
            self.seriesDatas = datas
        }
    }
    
    private func configureSeasonTableView() {
        seasonTableView.dataSource = self
        seasonTableView.delegate   = self
        seasonTableView.register(UINib(nibName: "SeasonTableViewCell", bundle: nil), forCellReuseIdentifier: "SeasonCell")
    }

}

extension SeasonListVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        seasons?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SeasonCell", for: indexPath) as? SeasonTableViewCell else { return UITableViewCell() }
        cell.seasonLabel.text = (seasons?[indexPath.row] ?? "") + ". Season"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let episodeListVC = storyboard?.instantiateViewController(withIdentifier: "EpisodeListVC") as? EpisodeListVC, let choosenSeason = seasons?[indexPath.row].trimmingCharacters(in: .whitespaces) else { return }
        
        var episodes: [SeasonModel] = []
        guard let datas = seriesDatas else { return }
        datas.forEach { data in
            if choosenSeason == data.season {
                episodes.append(data)
            }
        }
        episodeListVC.episodes = episodes
        episodeListVC.season   = choosenSeason
        navigationController?.pushViewController(episodeListVC, animated: true)
    }
}
