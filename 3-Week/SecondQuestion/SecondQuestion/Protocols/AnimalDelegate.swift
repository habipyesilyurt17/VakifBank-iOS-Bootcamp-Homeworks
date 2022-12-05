//
//  AnimalDelegate.swift
//  SecondQuestion
//
//  Created by Habip Yesilyurt on 20.11.2022.
//

import Foundation

protocol AnimalDelegate: AnyObject {
    func animalWasRegistered(_ animals: [Animal])
}
