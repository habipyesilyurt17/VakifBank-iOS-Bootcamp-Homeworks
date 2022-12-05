//
//  EmployeeDelegate.swift
//  FirstQuestion
//
//  Created by Habip Yesilyurt on 19.11.2022.
//

import UIKit

protocol EmployeeDelegate: AnyObject {
    func employeeWasRegistered(_ employees: [Employee])
}
