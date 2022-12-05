//
//  NotesListVC.swift
//  Homework
//
//  Created by Halil Yeşilyurt on 4.12.2022.
//

import UIKit

final class NotesListVC: BaseVC {

    @IBOutlet weak var notesTableView: UITableView!
    
    var notes: [Notes]?
    var selectedNote: Notes?
    private var seriesDatas: [SeasonModel]? {
        didSet {
            guard let datas = seriesDatas else { return }
            let seasonArr = datas.map { $0.season.trimmingCharacters(in: .whitespaces) }
            seasons = Set(seasonArr).sorted(by: <)
        }
    }
    
    private var seasons: [String]?
    
    private let floatingButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 60))

        button.backgroundColor = .systemPink
        
        let image = UIImage(systemName: "plus", withConfiguration: UIImage.SymbolConfiguration(pointSize: 32, weight: .medium))
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.setTitleColor(.white, for: .normal )
        button.layer.shadowRadius = 10
        button.layer.shadowOpacity = 0.3
        button.layer.cornerRadius = 30
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        EpisodeManager.shared.getEpisodes { [weak self] datas, error in
            guard let self = self else { return }
            //self.indicator.stopAnimating()
            self.seriesDatas = datas
        }
        
        getNotes()
        configureNotesTableView()
        view.addSubview(floatingButton)
        floatingButton.addTarget(self, action: #selector(addNoteButtonPressed), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(getNotes), name: NSNotification.Name(rawValue: "newData"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(getNotes), name: NSNotification.Name(rawValue: "updateData"), object: nil)
    }
    
    @objc private func getNotes() {
        self.notes?.removeAll()
        NotesManager.shared.fetchData(id: nil) { response in
            switch response {
            case .success(let notes):
                self.notes = notes
                self.notesTableView.reloadData()
            case .failure(let error):
                print("error: \(error)")
            }
        }
    }

    
    @objc func addNoteButtonPressed() {
        let noteFormVC = self.storyboard?.instantiateViewController(withIdentifier: "NoteFormVC") as? NoteFormVC
        guard let noteFormVC = noteFormVC else { return }
        noteFormVC.choosenFormLabel = "Add Form"
        noteFormVC.seasons  = seasons
        noteFormVC.seriesDatas = seriesDatas
        self.present(noteFormVC, animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        floatingButton.frame = CGRect(
            x: view.frame.size.width - 70,
            y: view.frame.size.height - 150,
            width: 60,
            height: 60)
    }
    
    private func configureNotesTableView() {
        notesTableView.dataSource = self
        notesTableView.delegate   = self
        notesTableView.register(UINib(nibName: "NotesTableViewCell", bundle: nil), forCellReuseIdentifier: "NotesCell")
        notesTableView.estimatedRowHeight = UITableView.automaticDimension
    }

}

extension NotesListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        notes?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NotesCell", for: indexPath) as? NotesTableViewCell, let model = notes?[indexPath.row] else { return UITableViewCell() }
        cell.configureCell(model: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let noteFormVC = storyboard?.instantiateViewController(withIdentifier: "NoteFormVC") as? NoteFormVC else { return }
        noteFormVC.choosenFormLabel = "Edit Form"
        selectedNote = notes?[indexPath.row]
        noteFormVC.choosenNote = selectedNote
        noteFormVC.seasons  = seasons
        noteFormVC.seriesDatas = seriesDatas
        self.present(noteFormVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .normal, title: nil) { action, view, complete in
            let noteId = self.notes?[indexPath.row].id
            NotesManager.shared.removeData(id: noteId) { isSuccess, error in
                if isSuccess {
                    self.getNotes()
                } else {
                    print("error: \(error.localizedDescription)")
                }
            }
        }
        deleteAction.image = UIImage(systemName: "trash.fill")?.colored(in: .white)
        deleteAction.backgroundColor = .red
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}
