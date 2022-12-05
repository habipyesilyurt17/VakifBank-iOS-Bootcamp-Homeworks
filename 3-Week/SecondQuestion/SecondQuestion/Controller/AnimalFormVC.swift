//
//  AnimalFormVC.swift
//  SecondQuestion
//
//  Created by Habip Yesilyurt on 20.11.2022.
//

import UIKit

class AnimalFormVC: UIViewController {
    weak var animalDelegate: AnimalDelegate?
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var waterLimit: UITextField!
    @IBOutlet weak var type: UITextField!
    
    var animals: [Animal] = []
    var listOfAnimalTypes = [AnimalTypes.cow.rawValue, AnimalTypes.crocodile.rawValue, AnimalTypes.donkey.rawValue, AnimalTypes.horse.rawValue, AnimalTypes.rabbit.rawValue]
    
    var animalPickerView = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        name.delegate = self
        waterLimit.delegate = self
        type.delegate = self
        setUpAnimalPickerView()
    }
    
    private func setUpAnimalPickerView() {
        type.inputView = animalPickerView
        animalPickerView.delegate = self
        animalPickerView.dataSource = self
        animalPickerView.tag = 1
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        var animal = Animal(name: "", voice: nil, dailyWaterConsumption: 0, type: nil)
        
        if let animalName = name.text {
            animal.name = animalName
        }
        if let animalDailyWaterConsumption = waterLimit.text {
            animal.dailyWaterConsumption = Float(animalDailyWaterConsumption) ?? 0
        }
        if let animalType = type.text {
            animal.type = AnimalTypes.init(rawValue: animalType)
        }
        
        animals.append(animal)
        animalDelegate?.animalWasRegistered(self.animals)
        navigationController?.popViewController(animated: true)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        waterLimit.resignFirstResponder()
    }

}

extension AnimalFormVC: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 1:
            return listOfAnimalTypes.count
        default:
            return 1
        }
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 1:
            return listOfAnimalTypes[row]
        default:
            return "Data not found"
        }
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 1:
            type.text = listOfAnimalTypes[row]
            type.resignFirstResponder()
        default:
            return
        }
    }
}

extension AnimalFormVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
