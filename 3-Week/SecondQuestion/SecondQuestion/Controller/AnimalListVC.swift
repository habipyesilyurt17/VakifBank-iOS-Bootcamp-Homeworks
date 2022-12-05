//
//  AnimalListVC.swift
//  SecondQuestion
//
//  Created by Habip Yesilyurt on 20.11.2022.
//

import UIKit

class AnimalListVC: UIViewController {

    var animals: [Animal] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }

    private func configureTableView() {
        tableView.delegate   = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "AnimalTableViewCell", bundle: nil), forCellReuseIdentifier: "AnimalTableViewCell")
        tableView.rowHeight = 100
    }

}


extension AnimalListVC:  UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        animals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AnimalTableViewCell", for: indexPath) as? AnimalTableViewCell else { return UITableViewCell() }
        cell.name.text   = animals[indexPath.row].name
        guard let animalType = animals[indexPath.row].type else { return UITableViewCell() }
        let animalTypeStr    = getAnimalType(type: animalType)
        cell.type.text = animalTypeStr
        cell.water.text    = String(animals[indexPath.row].dailyWaterConsumption)
        guard let animalZookeeper = animals[indexPath.row].zookeeper else { return UITableViewCell() }
        let animalZookeeperStr = getZookeeper(zookeeper: animalZookeeper)
        cell.zookeeper.text = animalZookeeperStr
            
        return cell
    }
    
    private func getZookeeper(zookeeper: Zookeeper) -> String {
        zookeeper.name
    }
    
    private func getAnimalType(type: AnimalTypes) -> String {
        switch type {
        case .cow:
            return type.rawValue
        case .rabbit:
            return type.rawValue
        case .crocodile:
            return type.rawValue
        case .horse:
            return type.rawValue
        case .donkey:
            return type.rawValue
        }
    }
}
