//
//  ZookeeperFormVC.swift
//  SecondQuestion
//
//  Created by Habip Yesilyurt on 20.11.2022.
//

import UIKit

class ZookeeperFormVC: UIViewController {
    weak var zookeeperDelegate: ZookeeperDelegate?
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var age: UITextField!
    @IBOutlet weak var experience: UITextField!
    
    var zookeepers: [Zookeeper] = []
    
    var listOfZookeeperExperiences = [ZookeeperExperience.jr.rawValue, ZookeeperExperience.mid.rawValue, ZookeeperExperience.sr.rawValue]
    
    var zookeeperExperiencePickerView = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        name.delegate = self
        age.delegate  = self
        experience.delegate = self
        
        setUpZookeeperExperiencePickerView()
    }
    
    private func setUpZookeeperExperiencePickerView() {
        experience.inputView   = zookeeperExperiencePickerView
        zookeeperExperiencePickerView.delegate   = self
        zookeeperExperiencePickerView.dataSource = self
        zookeeperExperiencePickerView.tag        = 1
    }
    
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        var zookeeper = Zookeeper(name: "", age: 0, salary: 0)
        
        if let zookeeperName = name.text {
            zookeeper.name = zookeeperName
        }
        if let zookeeperAge = age.text {
            zookeeper.age = Int(zookeeperAge) ?? 0
        }
        
        if let zookeeperExperience = experience.text {
            zookeeper.experience = ZookeeperExperience.init(rawValue: zookeeperExperience)
        }
        
        zookeeper.salary = calculateSalary(zookeeper: zookeeper)
        zookeepers.append(zookeeper)
        zookeeperDelegate?.zookeeperWasRegistered(zookeepers)
        navigationController?.popViewController(animated: true)
    }
    
    private func calculateSalary(zookeeper: Zookeeper) -> Float {
        let zookeeperSalaryWithoutCurrentLimit = Float(((Int(zookeeper.experience?.rawValue ?? "0") ?? 0) * zookeeper.age)*100)
        
        switch zookeeper.experience {
        case .jr:
            return zookeeperSalaryWithoutCurrentLimit + StaticSalaryValues.jrSalary.rawValue
        case .mid:
            return zookeeperSalaryWithoutCurrentLimit + StaticSalaryValues.midSalary.rawValue
        case .sr:
            return zookeeperSalaryWithoutCurrentLimit + StaticSalaryValues.srSalary.rawValue
        default:
            return 0
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        age.resignFirstResponder()
    }
    
}

extension ZookeeperFormVC: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 1:
            return listOfZookeeperExperiences.count
        default:
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 1:
            return listOfZookeeperExperiences[row]
        default:
            return "Data not found"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 1:
            experience.text = listOfZookeeperExperiences[row]
            experience.resignFirstResponder()
        default:
            return
        }
    }
}

extension ZookeeperFormVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
