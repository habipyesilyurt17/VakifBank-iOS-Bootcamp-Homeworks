//
//  NotesManagerDelegate.swift
//  Homework
//
//  Created by Halil Yeşilyurt on 4.12.2022.
//

import Foundation

enum CoreDataError: String, Error {
    case savingError   = "Data couldn't be saved"
    case removingError = "Data couldn't be removed"
    case fetchingError = "Data couldn't be fetched"
    case checkingError = "Data couldn't be checked"
    case noError
}

protocol NotesManagerDelegate {
    associatedtype T
    func saveData(data: T, completion: @escaping (_ isSuccess: Bool, CoreDataError)->())
    func fetchData(id: UUID?, completion: @escaping (Result<[T], CoreDataError>)->())
    func updateData(id: UUID?, updatedNote: Notes, completion: @escaping (_ isSuccess: Bool, CoreDataError)->())
    func removeData(id: UUID?, completion: @escaping (_ isSuccess: Bool, CoreDataError)->())
}
