//
//  CompanyVC.swift
//  FirstQuestion
//
//  Created by Habip Yesilyurt on 19.11.2022.
//

import UIKit

class CompanyVC: UIViewController {
    
    @IBOutlet weak var companyName: UILabel!
    @IBOutlet weak var companyFoundationYear: UILabel!
    @IBOutlet weak var companyRevenue: UILabel!
    @IBOutlet weak var companyOutgoing: UILabel!
    @IBOutlet weak var companyBudget: UILabel!
    @IBOutlet weak var companyEmployeesCount: UILabel!

    var employees: [Employee] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCompany()
    }
    
    
    func configureCompany() {
        let currentCompany = Company(name: "Yeşilyurt AŞ", foundationYear: 2022, revenue: 200_000, outgoing: 50_000, budget: 150_000)
        companyName.text           = currentCompany.name
        companyFoundationYear.text = String(currentCompany.foundationYear)
        companyRevenue.text        = String(currentCompany.revenue)
        companyOutgoing.text       = String(currentCompany.outgoing)
        companyBudget.text         = String(currentCompany.budget)
        companyEmployeesCount.text = String(currentCompany.employees.count)
    }
    
    
    @IBAction func showEmployeeListPressed(_ sender: Any) {
        if let employeeListVC = storyboard?.instantiateViewController(withIdentifier: "EmployeeListVC") as? EmployeeListVC {
            employeeListVC.employees = self.employees
            self.navigationController?.pushViewController(employeeListVC, animated: true)
        }
        
    }
    
    @IBAction func addEmployeePressed(_ sender: Any) {
        if let employeeFormVC = storyboard?.instantiateViewController(withIdentifier: "EmployeeFormVC") as? EmployeeFormVC {
            employeeFormVC.employeeDelegate = self
            self.navigationController?.pushViewController(employeeFormVC, animated: true)
        }
    }
    
    
    @IBAction func paymentEmployeesSalaryPressed(_ sender: Any) {
        let allEmployeesSalary = self.employees.reduce(0, { $0 + $1.salary })
        alertWithTextField(with: "Payment Employees Salary", "", "Payment", "Cancel", nil, String(allEmployeesSalary)) { amount in
            self.calculateExpense(amount: amount)
        }
    }
    
    
    @IBAction func addRevenuePressed(_ sender: Any) {
        alertWithTextField(with: "Add Revenue", "", "Add", "Cancel", "Enter revenue", nil) { revenue in
            guard let currentBudget  = Float(self.companyBudget.text ?? "0") else { return }
            guard let currentRevenue = Float(self.companyRevenue.text ?? "0") else { return }
            guard let newRevenue     = Float(revenue) else { return }
            self.companyRevenue.text = String(currentRevenue + newRevenue)
            self.companyBudget.text  = String(currentBudget + newRevenue)
        }
    }
    
    @IBAction func addOutgoingPressed(_ sender: Any) {
        alertWithTextField(with: "Add Expense", "", "Add", "Cancel", "Enter expense", nil) { expense in
            self.calculateExpense(amount: expense)
        }
    }
    
    func calculateExpense(amount: String) {
        guard let currentBudget   = Float(self.companyBudget.text ?? "0") else { return }
        guard let currentExpense  = Float(self.companyOutgoing.text ?? "0") else { return }
        guard let newExpense      = Float(amount) else { return }
        self.companyOutgoing.text = String(currentExpense + newExpense)
        self.companyBudget.text   = String(currentBudget - newExpense)
    }
    
}

extension CompanyVC: EmployeeDelegate {
    func employeeWasRegistered(_ employees: [Employee]) {
        self.employees += employees
        self.companyEmployeesCount.text = String(self.employees.count)
    }
}
