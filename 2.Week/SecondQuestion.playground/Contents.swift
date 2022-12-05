import UIKit

/*
 2- Playground üzerinden bir hayvanat bahçesi yönetimi yazılımı oluşturacağız. Aşağıdaki maddeleri karşılamalıdır.
 
 . Bahçemizde hayvanlarımız, bakıcılarımız olacak.
 . Hayvanat bahçemizin hem bir günlük su limiti hem de bit bütçesi olacak.
 . Hayvanat bahçesine gelir, gider eklemesi ve su limiti artırma yapılabilmelidir.
 . Hayvanların su tüketimleri, sesleri olmalı
 . Her hayvanın tek bakıcısı olmalıdır ancak bakıcılar birden fazla hayvana bakabilmelidir.
 . Bulunan hayvanların su tüketimleri günlük limitten düşmelidir.
 . Bakıcıların maaş ödemelerini yapılabilmeli. Hesap formulü kararı size bırakılmıştır.
 . Sonradan bakıcı ve hayvan eklemesi yapılabilmelidir.
 . Aynı hayvandan 1 den fazla olabilmelidir.
 . Protocol, closure, optional, computed property kullanımı zorunludur.
 */

enum StaticValues: Float {
    case dailyWaterLimit = 10_000
    case bitBudget       = 5_000
    case zookeepersPrice = 12_000
}

enum AnimalType {
    case cow, rabbit, crocodile, horse, donkey
}

protocol ZooProtocol {
    func addRevenue(amount: Float) -> Float
    func subtractionExpense(amount: Float) -> Float
    func waterLimitIncrease(water: Float)
    mutating func addAnimal(animal: Animal)
    mutating func addZookeeper(zookeeper: Zookeeper)
    mutating func PaymentZookeeper(zookeeper: Zookeeper, amount: Float)
    mutating func calculateDailyWaterLimits()
}

struct Zoo {
    let name: String
    var dailyWaterLimit: Float
    let bitBudget: Float
    var animals: [Animal] = []
    var zookeepers: [Zookeeper] = []
}

extension Zoo: ZooProtocol {
    func addRevenue(amount: Float) -> Float {
        let currentBudget = self.bitBudget + amount
        return currentBudget
    }
    
    func subtractionExpense(amount: Float) -> Float {
        let currentBudget = self.bitBudget - amount
        return currentBudget
    }
    
    func waterLimitIncrease(water: Float) {
        let newWaterLimit = self.dailyWaterLimit + water
        print("New daily water is \(newWaterLimit)")
    }
    
    mutating func addAnimal(animal: Animal) {
        animals.append(animal)
    }
    
    mutating func addZookeeper(zookeeper: Zookeeper) {
        zookeepers.append(zookeeper)
    }
    
    func PaymentZookeeper(zookeeper: Zookeeper, amount: Float) {
        var currentZookeeper = zookeeper
        currentZookeeper.price = amount
        print("Zookeeper \(zookeeper.fullName) \(amount) price paid.")
    }
    
    mutating func calculateDailyWaterLimits() {
        var allAnimalDailyWaterLimit: Float = 0_0
        for animal in animals {
            allAnimalDailyWaterLimit += animal.dailyWaterConsumption
        }
        print("All animals daily water limit is \(allAnimalDailyWaterLimit). The end of the day water limit is \(self.dailyWaterLimit - allAnimalDailyWaterLimit)")
        self.dailyWaterLimit -= allAnimalDailyWaterLimit
    }
}

struct Animal {
    let animalType: AnimalType
    let name: String?
    let voice: String?
    let dailyWaterConsumption: Float
    var zookeeper: Zookeeper?
    var zookeeperCount = 0
    
    mutating func setZookeeper(zookeeper: Zookeeper) {
        if zookeeperCount < 1 {
            self.zookeeper = zookeeper
            zookeeperCount += 1
        } else {
            guard let currentName = self.zookeeper?.fullName else { return }
            print("Your zookeeper is \(currentName). Each animal can have a maximum of 1 zookeeper.")
        }
    }
}

struct Zookeeper {
    var name: String
    var surname: String
    var age: Int
    var price: Float?
    var fullName: String {
        return "\(name) \(surname)"
    }
}

// Create a zoo.
var newZoo = Zoo(name: "Yeşil Vadi", dailyWaterLimit: StaticValues.dailyWaterLimit.rawValue, bitBudget: StaticValues.bitBudget.rawValue)
print(newZoo)

// Create new animals
var animal1 = Animal(animalType: AnimalType.cow, name: nil, voice: "möö", dailyWaterConsumption: 0_500, zookeeper: nil)
var animal2 = Animal(animalType: AnimalType.crocodile, name: "Bursa", voice: nil, dailyWaterConsumption: 0_200, zookeeper: nil)
var animal3 = Animal(animalType: AnimalType.donkey, name: "Karaoğlan", voice: "aii aii", dailyWaterConsumption: 0_300, zookeeper: nil)
var animal4 = Animal(animalType: AnimalType.cow, name: "Sarı Kız", voice: "möö", dailyWaterConsumption: 0_600, zookeeper: nil)

// Create new Zookeeper
var zookeeperAli  = Zookeeper(name: "Ali", surname: "At", age: 35, price: nil)
var zookeeperVeli = Zookeeper(name: "Veli", surname: "Can", age: 25, price: nil)
var zookeeperCan  = Zookeeper(name: "Can", surname: "Canan", age: 28, price: nil)

// Add animals in newZoo
newZoo.addAnimal(animal: animal1)
newZoo.addAnimal(animal: animal2)
newZoo.addAnimal(animal: animal3)
newZoo.addAnimal(animal: animal4)
print("All newZoo Animals = \(newZoo.animals)")

// Add zookeepers i newZoo
newZoo.addZookeeper(zookeeper: zookeeperAli)
newZoo.addZookeeper(zookeeper: zookeeperVeli)
newZoo.addZookeeper(zookeeper: zookeeperCan)
print("All newZoo Zookeepers = \(newZoo.zookeepers)")

// set Animal's zookeeper
animal1.setZookeeper(zookeeper: zookeeperAli)
if let animal1Zookeeper = animal1.zookeeper {
    print("animal1 zookeeper's is \(animal1Zookeeper.fullName). He is \(animal1Zookeeper.age) year old.")
}
animal1.setZookeeper(zookeeper: zookeeperCan) // Each animal can have a maximum of 1 zookeeper.
animal2.setZookeeper(zookeeper: zookeeperAli)
if let animal2Zookeeper = animal2.zookeeper {
    print("animal2 zookeeper's is \(animal2Zookeeper.fullName). He is \(animal2Zookeeper.age) year old.")
}
animal3.setZookeeper(zookeeper: zookeeperCan)
if let animal3Zookeeper = animal3.zookeeper {
    print("animal3 zookeeper's is \(animal3Zookeeper.fullName). He is \(animal3Zookeeper.age) year old.")
}
animal4.setZookeeper(zookeeper: zookeeperCan)
if let animal4Zookeeper = animal4.zookeeper {
    print("animal4 zookeeper's is \(animal4Zookeeper.fullName). He is \(animal4Zookeeper.age) year old.")
}

// newZoo calculateDailyWaterLimits
newZoo.calculateDailyWaterLimits()

// newZoo waterLimitIncrease
newZoo.waterLimitIncrease(water: 4_000)

// Calculate water limit again
newZoo.calculateDailyWaterLimits()


// Example of adding revenues to the bit budget
print("New Bit Budget is \(newZoo.addRevenue(amount: 20_00))")

// Example of subtracting expenses from the bit budget
print("New Bit Budget is \(newZoo.subtractionExpense(amount: 4_000))")

// Payment zookeeper's price
newZoo.PaymentZookeeper(zookeeper: zookeeperAli, amount: StaticValues.zookeepersPrice.rawValue)
newZoo.PaymentZookeeper(zookeeper: zookeeperCan, amount: StaticValues.zookeepersPrice.rawValue)
newZoo.PaymentZookeeper(zookeeper: zookeeperVeli, amount: StaticValues.zookeepersPrice.rawValue)
