//
//  NoteFormVC.swift
//  Homework
//
//  Created by Halil Yeşilyurt on 4.12.2022.
//

import UIKit
import CoreData

class NoteFormVC: UIViewController {
    @IBOutlet weak var formLabel: UILabel!
    @IBOutlet weak var seasonTextField: UITextField!
    @IBOutlet weak var episodeTextField: UITextField!
    @IBOutlet weak var noteTextField: UITextField!
    
    var choosenFormLabel: String?
    var choosenNote: Notes?
    
    var seriesDatas: [SeasonModel]?
    
    var seasons: [String]? {
        didSet {
            listOfSeason = seasons ?? []
        }
    }
    var episodes: [String] = [] {
        didSet {
            listOfEpisode = episodes
            episodePickerView.reloadInputViews()
        }
    }
    
    var listOfSeason: [String] = []
    var listOfEpisode: [String] = []
    
    var seasonPickerView = UIPickerView()
    var episodePickerView = UIPickerView()
    
    var notes: [Notes] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        formLabel?.text = choosenFormLabel ?? ""
        if let note = choosenNote {
            if let season = note.season {
                self.seasonTextField.text = season
            }
            if let episode = note.episode {
                self.episodeTextField.text = episode
            }
            if let note = note.note {
                self.noteTextField.text = note
            }
        }
        fetchNotes()
        seasonTextField.delegate = self
        episodeTextField.delegate = self
        noteTextField.delegate = self
        setUpSeasonPickerView()
        setUpEpisodePickerView()
    }
    
    private func setUpSeasonPickerView() {
        seasonTextField.inputView = seasonPickerView
        seasonPickerView.delegate = self
        seasonPickerView.dataSource = self
        seasonPickerView.tag = 1
    }
    
    private func setUpEpisodePickerView() {
        episodeTextField.inputView = episodePickerView
        episodePickerView.delegate = self
        episodePickerView.dataSource = self
        episodePickerView.tag = 2
    }
    
    private func fetchNotes() {
        NotesManager.shared.fetchData(id: nil) { response in
            switch response {
            case .success(let notes):
                self.notes = notes
            case .failure(let error):
                print("error: \(error)")
            }
        }
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        guard let formTitle = formLabel.text else { return }
        
        if formTitle == "Edit Form" {
            print("updateNote")
            let updatedNote = Notes(context: NotesManager.shared.context)
            updatedNote.id = choosenNote?.id
            if let season = seasonTextField.text {
                updatedNote.season = season
            }
            if let episode = episodeTextField.text {
                updatedNote.episode = episode
            }
            if let note = noteTextField.text {
                updatedNote.note = note
            }
            guard let choosenNote = choosenNote else { return }
            NotesManager.shared.updateData(id: choosenNote.id, updatedNote: updatedNote) { isSuccess, updateError in
                if isSuccess {
                    NotificationCenter.default.post(name: NSNotification.Name("updateData"), object: nil)
                } else {
                    print("error: \(updateError)")
                }
            }
            
        } else {
            print("newNote")
            let newNote = Notes(context: NotesManager.shared.context)
            newNote.id = UUID()
            
            if let season = seasonTextField.text {
                newNote.season = season
            }
            if let episode = episodeTextField.text {
                newNote.episode = episode
            }
            if let note = noteTextField.text {
                newNote.note = note
            }
            NotesManager.shared.saveData(data: newNote) { isSuccess, saveError in
                if isSuccess {
                    self.notes.append(newNote)
                } else {
                    print("error: \(saveError)")
                }
            }
            NotificationCenter.default.post(name: NSNotification.Name("newData"), object: nil)
        }
        self.dismiss(animated: true, completion: nil)
    }
    

}

extension NoteFormVC: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 1:
            return listOfSeason.count
        case 2:
            return listOfEpisode.count
        default:
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 1:
            return listOfSeason[row]
        case 2:
            return listOfEpisode[row]
        default:
            return "Data not found"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 1:
            seasonTextField.text = listOfSeason[row]
            guard let season = seasonTextField.text else { return }
            self.seriesDatas?.forEach { data in
                if season == data.season {
                    self.episodes.append(data.title)
                }
            }
            seasonTextField.resignFirstResponder()
        case 2:
            episodeTextField.text = listOfEpisode[row]
            episodeTextField.resignFirstResponder()
        default:
            return
        }
    }
}

extension NoteFormVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
