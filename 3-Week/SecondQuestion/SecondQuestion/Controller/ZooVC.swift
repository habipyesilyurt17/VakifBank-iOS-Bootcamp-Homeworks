//
//  ZooVC.swift
//  SecondQuestion
//
//  Created by Habip Yesilyurt on 20.11.2022.
//

import UIKit

class ZooVC: UIViewController {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var foundationYear: UILabel!
    @IBOutlet weak var revenue: UILabel!
    @IBOutlet weak var outgoing: UILabel!
    @IBOutlet weak var waterLimit: UILabel!
    @IBOutlet weak var budget: UILabel!
    @IBOutlet weak var animalsCount: UILabel!
    @IBOutlet weak var zookeepersCount: UILabel!
    
    var animals: [Animal] = []
    var zookeepers: [Zookeeper] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureZoo()
    }
    
    private func configureZoo() {
        let currentZoo = Zoo(name: "Yeşil Vadi", foundationYear: 2018, revenue: 300_000, outgoing: 150_000, dailyWaterLimit: 15_000, budget: 150_000)
        name.text            = currentZoo.name
        foundationYear.text  = String(currentZoo.foundationYear)
        revenue.text         = String(currentZoo.revenue)
        outgoing.text        = String(currentZoo.outgoing)
        waterLimit.text      = String(currentZoo.dailyWaterLimit)
        budget.text          = String(currentZoo.budget)
        animalsCount.text    = String(currentZoo.animals.count)
        zookeepersCount.text = String(currentZoo.zookeepers.count)

    }
    
    @IBAction func showAnimalListPressed(_ sender: Any) {
        if let animalListVC = storyboard?.instantiateViewController(withIdentifier: "AnimalListVC") as? AnimalListVC {
            animalListVC.animals = self.animals
            self.navigationController?.pushViewController(animalListVC, animated: true)
        }
    }
    
    @IBAction func showZookeeperListPressed(_ sender: Any) {
        if let zookeeperListVC = storyboard?.instantiateViewController(withIdentifier: "ZookeeperListVC") as? ZookeeperListVC {
            zookeeperListVC.zookeepers = self.zookeepers
            self.navigationController?.pushViewController(zookeeperListVC, animated: true)
        }
        
        
    }
    
    @IBAction func paymentZookeepersSalaryPressed(_ sender: Any) {
        let allZookeepersSalary = self.zookeepers.reduce(0, { $0 + $1.salary })
        alertWithTextField(with: "Payment Zookeepers Salary", "", "Payment", "Cancel", nil, String(allZookeepersSalary)) { amount in
            self.calculateExpense(amount: amount)
        }
    }
    
    @IBAction func addRevenuePressed(_ sender: Any) {
        alertWithTextField(with: "Add Revenue", "", "Add", "Cancel", "Enter revenue", nil) { revenue in
            guard let currentBudget  = Float(self.budget.text ?? "0") else { return }
            guard let currentRevenue = Float(self.revenue.text ?? "0") else { return }
            guard let newRevenue     = Float(revenue) else { return }
            self.revenue.text        = String(currentRevenue + newRevenue)
            self.budget.text         = String(currentBudget + newRevenue)
        }
    }
    
    @IBAction func addOutgoingPressed(_ sender: Any) {
        alertWithTextField(with: "Add Expense", "", "Add", "Cancel", "Enter expense", nil) { expense in
            self.calculateExpense(amount: expense)
        }
    }
    
    private func calculateExpense(amount: String) {
        guard let currentBudget  = Float(self.budget.text ?? "0") else { return }
        guard let currentExpense = Float(self.outgoing.text ?? "0") else { return }
        guard let newExpense     = Float(amount) else { return }
        self.outgoing.text       = String(currentExpense + newExpense)
        self.budget.text         = String(currentBudget - newExpense)
    }
    
    @IBAction func addWaterLimitPressed(_ sender: Any) {
        alertWithTextField(with: "Add Water", "", "Add", "Cancel", "Enter water", nil) { water in
            guard let currentWater = Float(self.waterLimit.text ?? "0") else { return }
            guard let newWater     = Float(water) else { return }
            self.waterLimit.text   = String(currentWater + newWater)
        }
    }
    
    @IBAction func addAnimalPressed(_ sender: Any) {
        if let animalFormVC = storyboard?.instantiateViewController(withIdentifier: "AnimalFormVC") as? AnimalFormVC {
            animalFormVC.animalDelegate = self
            self.navigationController?.pushViewController(animalFormVC, animated: true)
        }
    }
    
    @IBAction func addZookeeperPressed(_ sender: Any) {
        if let zookeeperFormVC = storyboard?.instantiateViewController(withIdentifier: "ZookeeperFormVC") as? ZookeeperFormVC {
            zookeeperFormVC.zookeeperDelegate = self
            self.navigationController?.pushViewController(zookeeperFormVC, animated: true)
        }
    }

}

extension ZooVC: AnimalDelegate {
    func animalWasRegistered(_ animals: [Animal]) {
        self.animals += animals
        self.animalsCount.text = String(self.animals.count)
    }
}

extension ZooVC: ZookeeperDelegate {
    func zookeeperWasRegistered(_ zookeepers: [Zookeeper]) {
        self.zookeepers += zookeepers
        self.zookeepersCount.text = String(self.zookeepers.count)
    }
}
