//
//  NotesManager.swift
//  Homework
//
//  Created by Halil Yeşilyurt on 4.12.2022.
//

import UIKit
import CoreData


final class NotesManager: NotesManagerDelegate {
    static let shared = NotesManager()
    typealias T = Notes
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func saveData(data: Notes, completion: @escaping (Bool, CoreDataError) -> ()) {
        do {
            try self.context.save()
            completion(true, .noError)
        } catch {
            print("error: \(error.localizedDescription)")
            completion(false, .savingError)
        }
    }
    
    func fetchData(id: UUID?, completion: @escaping (Result<[Notes], CoreDataError>) -> ()) {
        let fetchRequest = NSFetchRequest<Notes>(entityName: "Notes")
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let results = try context.fetch(fetchRequest)
            if results.count > 0 {
                completion(.success(results))
            }
        } catch {
            print("error: \(error.localizedDescription)")
            completion(.failure(.fetchingError))
        }
    }
    
    func updateData(id: UUID?, updatedNote: Notes, completion: @escaping (Bool, CoreDataError) -> ()) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Notes")
        guard let id = id else { return }
        let idString     = id.uuidString

        fetchRequest.predicate = NSPredicate(format: "id = %@", idString)
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let results = try  context.fetch(fetchRequest)
            if results.count == 1 {
                let objectUpdate = results[0] as! NSManagedObject
                if id == objectUpdate.value(forKey: "id") as? UUID {
                    objectUpdate.setValue(updatedNote.season, forKey: "season")
                    objectUpdate.setValue(updatedNote.episode, forKey: "episode")
                    objectUpdate.setValue(updatedNote.note, forKey: "note")
                }
                do {
                    try context.save()
                    completion(true, .noError)
                } catch {
                    print("error: \(error.localizedDescription)")
                    completion(false, .savingError)
                }
            }
        } catch {
            print("error: \(error.localizedDescription)")
            completion(false, .fetchingError)
        }
    }
    
    func removeData(id: UUID?, completion: @escaping (Bool, CoreDataError) -> ()) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Notes")
        guard let idString     = id?.uuidString else { return }
        fetchRequest.predicate = NSPredicate(format: "id = %@", idString)
        fetchRequest.returnsObjectsAsFaults = false
        let request = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try context.execute(request)
            try context.save()
            completion(true, .noError)
        } catch {
            print("error: \(error.localizedDescription)")
            completion(false, .removingError)
        }
    }
}
