//
//  ViewController.swift
//  NotesApp
//
//  Created by Timur Begishev on 17.03.2021.
//

import UIKit

class NotesListViewController: UITableViewController {
	
	private let reuseIdentifier = "NoteCell"
	
	private var notes = [
		Note(title: "0", date: Date()),
		Note(title: "1", date: Date().addingTimeInterval(-180)),
		Note(title: "2", date: Date().addingTimeInterval(-24 * 60 * 60)),
		Note(title: "3", date: Date().addingTimeInterval(-25 * 60 * 60)),
		Note(title: "4", date: Date().addingTimeInterval(-48 * 60 * 60)),
		Note(title: "5 note with super long title, that don't fit\nin one line of cell and i think it'll take even more then two lines", date: Date().addingTimeInterval(-72 * 60 * 60))
	]

	override func viewDidLoad() {
		super.viewDidLoad()
		title = "My Notes"
		
		navigationItem.rightBarButtonItem = UIBarButtonItem(title: "New",
														   style: .plain,
														   target: self,
														   action: #selector(addNewNote))
		
		tableView.register(NoteCell.self, forCellReuseIdentifier: reuseIdentifier)
		tableView.tableFooterView = UIView()
	}
	
	@objc
	private func addNewNote() {
		let targetVC = NoteViewController()
		
		let newNote = Note(title: "New Note", date: Date())
		
		notes.append(newNote)
		tableView.insertRows(at: [IndexPath(item: 0, section: 0)], with: .automatic)
		targetVC.configure(with: newNote)
		navigationController?.pushViewController(targetVC, animated: true)
	}
	
	private func removeAction(at indexPath: IndexPath) -> UIContextualAction {
		let action = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (_, _, completion) in
			guard let self = self else {
				completion(false)
				return
			}
			let index = self.notes.count - 1 - indexPath.row
			self.notes.remove(at: index)
			self.tableView.deleteRows(at: [indexPath], with: .automatic)
			completion(true)
		}
		return action
	}

	
	//MARK: - TableView data source methods
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return notes.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? NoteCell else { return UITableViewCell() }
		
		let index = notes.count - 1 - indexPath.row
		let note = notes[index]
		cell.configure(with: note)
		
		return cell
	}
	
	//MARK: - TableView delegate methods
	override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
		let remove = removeAction(at: indexPath)
		return UISwipeActionsConfiguration(actions: [remove])
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		
		let targetVC = NoteViewController()
		
		let index = notes.count - 1 - indexPath.row
		let note = notes[index]
		targetVC.configure(with: note)
		
		navigationController?.pushViewController(targetVC, animated: true)
	}
	
	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 60
	}

}

