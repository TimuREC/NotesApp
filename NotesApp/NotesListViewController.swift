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
		Note(title: "0"),
		Note(title: "1"),
		Note(title: "2"),
		Note(title: "3"),
		Note(title: "4"),
		Note(title: "5 note with super long title, that don't fit in one line of cell and i think it'll take even more then two lines")
	]

	override func viewDidLoad() {
		super.viewDidLoad()
		title = "My Notes"
		tableView.register(NoteCell.self, forCellReuseIdentifier: reuseIdentifier)
		tableView.tableFooterView = UIView()
	}

	
	//MARK: - TableView data source methods
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return notes.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? NoteCell else { return UITableViewCell() }
		
		let note = notes[indexPath.row]
		cell.configure(with: note)
		cell.dateLabel.text = "23/03/2021"
		
		return cell
	}
	
	//MARK: - TableView delegate methods
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		
		let targetVC = NoteViewController()
		
		let note = notes[indexPath.row]
		targetVC.title = note.title
		
		navigationController?.pushViewController(targetVC, animated: true)
	}
	
	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 60
	}

}

