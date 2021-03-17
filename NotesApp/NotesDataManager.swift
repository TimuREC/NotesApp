//
//  NotesDataManager.swift
//  NotesApp
//
//  Created by Timur Begishev on 17.03.2021.
//

import UIKit

class NotesDataManager: NSObject {
	
	var dummyNotes = [
		Note(title: "0", date: Date()),
		Note(title: "1", date: Date().addingTimeInterval(-180)),
		Note(title: "2", date: Date().addingTimeInterval(-24 * 60 * 60)),
		Note(title: "3", date: Date().addingTimeInterval(-25 * 60 * 60)),
		Note(title: "4", date: Date().addingTimeInterval(-48 * 60 * 60)),
		Note(title: "5 note with super long title, that don't fit\nin one line of cell and i think it'll take even more then two lines", date: Date().addingTimeInterval(-72 * 60 * 60))
	]
	
	var notesCount: Int { return dummyNotes.count }
	
	func addNote(_ note: Note) {
		dummyNotes.append(note)
	}
	
	func getNote(for indexPath: IndexPath) -> Note {
		let index = notesCount - 1 - indexPath.row
		return dummyNotes[index]
	}
	
	func removeNote(at indexPath: IndexPath) {
		let index = notesCount - 1 - indexPath.row
		dummyNotes.remove(at: index)
	}
	
}

//MARK: - TableView data source
extension NotesDataManager: UITableViewDataSource {
	
	var cellReuseIdentifier: String { return "NoteCell" }
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return dummyNotes.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as? NoteCell else { return UITableViewCell() }
		
		let index = dummyNotes.count - 1 - indexPath.row
		let note = dummyNotes[index]
		cell.configure(with: note)
		
		return cell
	}
}
