import UIKit

// 1- Playground üzerinden bir şirket yazılımı oluşturacağız. Aşağıdaki maddeler yazılımda karşılanmalıdır.
/*
 Şirketimizin isim, çalışan, bütçe, kuruluş yılı olacak. +
 Şirkete çalışan ekleyebilmeliyim. +
 Çalışanlar için en az isim, yaş, medeni hal tutulmalı. +
 En az 3 çalışan tipi olmalı. Jr. Mid. Sr. gibi. +
 Çalışanların maaşları yaş ve tip arasında bir formül belirleyerek hesaplanmalı. yaş * tip_katsayısı * 1000 gibi +
 Şirketimize playground arayüzünden gelir ekleyip gider çıkışı sağlayabilmeliyim. +
 Şirketimin maaş ödemesini yapan bir metodu olmalı. +
 Ödenen maaşlar bütçeden düşmeli +
 Maaş ödemesi yapıldıktan sonra yazılım bana ekstra yapabileceğim komutlara izin vermeli. +
 Protocol, closure, optional kullanımı zorunludur. +
 */

enum MaritalStatus {
    case single
    case married
}

enum EmployeeTypes: Int {
    case jr = 2
    case mid = 4
    case sr = 6
}

enum StaticValues: Double {
    case jrSalary  = 5_000
    case midSalary = 10_000
    case srSalary  = 15_000
    case budget    = 40_000
}

struct Employee {
    var name: String
    var age: Int
    var maritalStatus: MaritalStatus
    var salary: Double?
    var type: EmployeeTypes
}

protocol CompanyProtocol {
    mutating func addEmployee(employee: Employee)
    func calculateSalary(employee: Employee) -> Double?
    mutating func salaryPayment(employees: [Employee], completion: (Bool, Double) -> ())
    func addRevenue(amount: Double) -> Double
    func subtractionExpense(amount: Double) -> Double
}

struct Company {
    let name: String
    var employees: [Employee] = []
    var budget: Double
    let foundationYear: Int
    let jrSalaryLimit  = StaticValues.jrSalary.rawValue
    let midSalaryLimit = StaticValues.midSalary.rawValue
    let srSalaryLimit  = StaticValues.srSalary.rawValue
}

extension Company: CompanyProtocol {
    mutating func addEmployee(employee: Employee) {
        self.employees.append(employee)
    }
    
    func calculateSalary(employee: Employee) -> Double? {
        let employeSalaryWithoutCurrentLimit = Double((employee.type.rawValue * employee.age)*100)
        switch employee.type {
        case .jr:
            return self.jrSalaryLimit  + employeSalaryWithoutCurrentLimit
        case .mid:
            return self.midSalaryLimit + employeSalaryWithoutCurrentLimit
        case .sr:
            return self.srSalaryLimit  + employeSalaryWithoutCurrentLimit
        }
    }
    
    mutating func salaryPayment(employees: [Employee], completion: (Bool, Double) -> ()) {
        var totalSalaryPayments = 0.0
        for employee in employees {
            totalSalaryPayments += employee.salary ?? 0.0
            self.budget -= employee.salary ?? 0.0
        }
        if self.budget >= totalSalaryPayments {
            print("Budget sufficient for salary payments")
            completion(true, self.budget)
        } else {
            print("Budget is not sufficient for salary payments")
            completion(false, self.budget)
        }
    }
    
    func addRevenue(amount: Double) -> Double {
        let currentBudget = self.budget + amount
        return currentBudget
    }
    
    func subtractionExpense(amount: Double) -> Double {
        let currentBudget = self.budget - amount
        return currentBudget
    }
}

// Create a company.
var company = Company(name: "Yesilyurt", employees: [], budget: StaticValues.budget.rawValue, foundationYear: 2021)

// create a employee
var employee1 =  Employee(name: "Habip Yeşilyurt", age: 30, maritalStatus: MaritalStatus.married, salary: nil, type: EmployeeTypes.jr)
var employee2 = Employee(name: "Hifa Yeşilyurt", age: 40, maritalStatus: MaritalStatus.single, salary: nil, type: EmployeeTypes.sr)

// i create another employee like this. Because I want to show that employee1 values are not affected when employee3 value changes.
var employee3    = employee1
employee3.name   = "Ebrar Yeşilyurt"
employee3.age    = 25
employee3.salary = nil
employee3.type   = EmployeeTypes.mid

// Add employee for new company.
company.addEmployee(employee: employee1)
company.addEmployee(employee: employee2)
company.addEmployee(employee: employee3)

// Showing company's employees
print("\(company.name) company's employees = \(company.employees)")

// Change employees salary with company calculateSalary method.
if let employee1Salary = company.calculateSalary(employee: employee1) {
    print("employee1 salary = \(employee1Salary)")
}

if let employee2Salary = company.calculateSalary(employee: employee2) {
    print("employee2 salary = \(employee2Salary)")
}

if let employee3Salary = company.calculateSalary(employee: employee3) {
    print("employee3 salary = \(employee3Salary)")
}

company.salaryPayment(employees: company.employees) { isSuccess, budget in
    if isSuccess {
        print("The \(budget) budget is sufficient")
    } else {
        print("Please add revenue. \(budget) budget is not enough.")
    }
}

// Example of adding revenues to the budget
let revenueAddedBudget = company.addRevenue(amount: 10_000)
print("New Budget = \(revenueAddedBudget)")

// Example of subtracting expenses from the budget
let expenseBudget = company.subtractionExpense(amount: 1_000)
print("New Budget = \(expenseBudget)")
