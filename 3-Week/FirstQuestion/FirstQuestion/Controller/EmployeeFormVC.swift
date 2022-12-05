//
//  EmployeeFormVC.swift
//  FirstQuestion
//
//  Created by Habip Yesilyurt on 19.11.2022.
//

import UIKit

class EmployeeFormVC: UIViewController {
    weak var employeeDelegate: EmployeeDelegate?
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var age: UITextField!
    @IBOutlet weak var maritalStatusTextField: UITextField!
    @IBOutlet weak var employeeTypeTextField: UITextField!
    @IBOutlet weak var employeeExperienceTextField: UITextField!
    @IBOutlet weak var employeePositionTextField: UITextField!
    
    
    
    var employees: [Employee] = []
    
    var listOfMaritalStatus = [MaritalStatus.single.rawValue, MaritalStatus.married.rawValue]
    var listOfEmployeeTypes = [EmployeeTypes.jr.rawValue, EmployeeTypes.mid.rawValue, EmployeeTypes.sr.rawValue]
    var listOfEmployeeExperiences = [EmployeeExperience.jr.rawValue, EmployeeExperience.mid.rawValue, EmployeeExperience.sr.rawValue]
    var listOfPosition      = [EmployeePositions.ios.rawValue, EmployeePositions.backEnd.rawValue, EmployeePositions.frontEnd.rawValue]
    
    var maritalStatusPickerView = UIPickerView()
    var employeePickerView      = UIPickerView()
    var experiencePickerView    = UIPickerView()
    var positionPickerView      = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        name.delegate = self
        age.delegate  = self
        maritalStatusTextField.delegate = self
        employeeTypeTextField.delegate  = self
        employeeExperienceTextField.delegate = self
        employeePositionTextField.delegate = self
        
        setUpMaritalStatusPickerView()
        setUpEmployeePickerView()
        setUpExperiencePickerView()
        setUpPositionPickerView()
    }

    func setUpMaritalStatusPickerView() {
        maritalStatusTextField.inputView   = maritalStatusPickerView
        maritalStatusPickerView.delegate   = self
        maritalStatusPickerView.dataSource = self
        maritalStatusPickerView.tag        = 1
    }
    
    func setUpEmployeePickerView() {
        employeeTypeTextField.inputView = employeePickerView
        employeePickerView.delegate     = self
        employeePickerView.dataSource   = self
        employeePickerView.tag          = 2
    }
    
    func setUpExperiencePickerView() {
        employeeExperienceTextField.inputView = experiencePickerView
        experiencePickerView.delegate         = self
        experiencePickerView.dataSource       = self
        experiencePickerView.tag              = 3
    }
    
    func setUpPositionPickerView() {
        employeePositionTextField.inputView = positionPickerView
        positionPickerView.delegate         = self
        positionPickerView.dataSource       = self
        positionPickerView.tag              = 4
    }
    
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        var employee = Employee(name: "", age: 0, maritalStatus: nil, level: nil, experience: nil, position: nil, salary: 0)
        
        
        if let employeeName = name.text {
            employee.name = employeeName
        }
        if let employeeAge = age.text {
            employee.age = Int(employeeAge) ?? 0
        }
        if let employeeMaritalStatus = maritalStatusTextField.text {
            employee.maritalStatus =  MaritalStatus.init(rawValue: employeeMaritalStatus)
        }
        if let employeeType = employeeTypeTextField.text {
            employee.level = EmployeeTypes.init(rawValue: employeeType)
        }
        if let employeeExperience = employeeExperienceTextField.text {
            employee.experience = EmployeeExperience.init(rawValue: employeeExperience)
        }
        if let employeePosition = employeePositionTextField.text {
            employee.position =  EmployeePositions.init(rawValue: employeePosition)
        }
        
        employee.salary = calculateSalary(employee: employee)
        
        employees.append(employee)
        employeeDelegate?.employeeWasRegistered(self.employees)
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    func calculateSalary(employee: Employee) -> Float {
        
        let employeSalaryWithoutCurrentLimit = Float(((Int(employee.experience?.rawValue ?? "0") ?? 0) * employee.age)*100)
        switch employee.level {
        case .jr:
            return employeSalaryWithoutCurrentLimit + StaticSalaryValues.jrSalary.rawValue
        case .mid:
            return employeSalaryWithoutCurrentLimit + StaticSalaryValues.midSalary.rawValue
        case .sr:
            return employeSalaryWithoutCurrentLimit + StaticSalaryValues.srSalary.rawValue
        default:
            return 0
        }
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        age.resignFirstResponder()
    }
}


extension EmployeeFormVC: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 1:
            return listOfMaritalStatus.count
        case 2:
            return listOfEmployeeTypes.count
        case 3:
            return listOfEmployeeExperiences.count
        case 4:
            return listOfPosition.count
        default:
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 1:
            return listOfMaritalStatus[row]
        case 2:
            return listOfEmployeeTypes[row]
        case 3:
            return listOfEmployeeExperiences[row]
        case 4:
            return listOfPosition[row]
        default:
            return "Data not found"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 1:
            maritalStatusTextField.text = listOfMaritalStatus[row]
            maritalStatusTextField.resignFirstResponder()
        case 2:
            employeeTypeTextField.text = listOfEmployeeTypes[row]
            employeeTypeTextField.resignFirstResponder()
        case 3:
            employeeExperienceTextField.text = listOfEmployeeExperiences[row]
            employeeExperienceTextField.resignFirstResponder()
        case 4:
            employeePositionTextField.text = listOfPosition[row]
            employeePositionTextField.resignFirstResponder()
        default:
            return
        }
    }
}

extension EmployeeFormVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
