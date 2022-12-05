//
//  EmployeeListVC.swift
//  FirstQuestion
//
//  Created by Habip Yesilyurt on 19.11.2022.
//

import UIKit

class EmployeeListVC: UIViewController {

    var employees: [Employee] = []
    var filteredEmployees: [Employee] = []
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var employeesTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        filteredEmployees = employees
        configureSearchBar()
        configureEmployeesTableView()
    }
    
    func configureSearchBar() {
        searchBar.placeholder = "Search a Employee"
        searchBar.delegate    = self
    }
    
    func configureEmployeesTableView() {
        employeesTableView.delegate   = self
        employeesTableView.dataSource = self
        employeesTableView.register(UINib(nibName: "EmployeeTableViewCell", bundle: nil), forCellReuseIdentifier: "EmployeeCell")
        employeesTableView.rowHeight = 70
    }

}

extension EmployeeListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredEmployees.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EmployeeCell", for: indexPath) as? EmployeeTableViewCell else { return UITableViewCell() }
        cell.name.text   = filteredEmployees[indexPath.row].name
        cell.age.text    =  " - " + String(filteredEmployees[indexPath.row].age)
        cell.salary.text = " / " + String(filteredEmployees[indexPath.row].salary)
        
        guard let maritalStatus = filteredEmployees[indexPath.row].maritalStatus else { return UITableViewCell() }
        let maritalStatusStr    = getEmployeeMaritalStatus(status: maritalStatus)
        cell.maritalStatus.text = " / " + maritalStatusStr
        
        guard let employeeLevel = filteredEmployees[indexPath.row].level else { return UITableViewCell() }
        let employeeLevelStr    = getEmployeeLevel(level: employeeLevel)
        
        guard let employePosition = filteredEmployees[indexPath.row].position else  { return UITableViewCell() }
        let employePositionStr    = getEmployeePosition(position: employePosition)
        cell.workPosition.text    = employeeLevelStr + " " + employePositionStr
        
        return cell
    }
    
    func getEmployeeMaritalStatus(status: MaritalStatus) -> String {
        switch status {
        case .single:
            return status.rawValue
        case .married:
            return status.rawValue
        }
    }
    
    func getEmployeeLevel(level: EmployeeTypes) -> String {
        switch level {
        case .jr:
            return level.rawValue
        case .mid:
            return level.rawValue
        case .sr:
            return level.rawValue
        }
    }

    func getEmployeePosition(position: EmployeePositions) -> String {
        switch position {
        case .ios:
            return position.rawValue
        case .backEnd:
            return position.rawValue
        case .frontEnd:
            return position.rawValue
        }
    }
}

extension EmployeeListVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredEmployees = []
        if searchText == "" {
            filteredEmployees = employees
        } else {
            for employee in employees {
                if employee.name.lowercased().contains(searchText.lowercased()) {
                    filteredEmployees.append(employee)
                }
            }
        }
        self.employeesTableView.reloadData()
    }
}
