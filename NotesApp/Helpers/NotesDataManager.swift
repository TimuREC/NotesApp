//
//  NotesDataManager.swift
//  NotesApp
//
//  Created by Timur Begishev on 17.03.2021.
//

import UIKit
import CoreData

class NotesDataManager: NSObject {
	
	let context: NSManagedObjectContext!
	
	var notes: [Note]
	
	var notesCount: Int { return notes.count }
	
	override init() {
		notes = []
		let appDelegate = UIApplication.shared.delegate as? AppDelegate
		context = appDelegate?.persistentContainer.viewContext
		super.init()
		
		guard let _ = UserDefaults.standard.value(forKeyPath: "FirstStart") else {
			let firstNote = Note(context: context)
			firstNote.title = "Добро пожаловать в NotesApp!"
			firstNote.text = NSAttributedString(string: "Добро пожаловать в NotesApp!\n\nМы рады приветствовать нашего нового пользователя!\n\nЭто приложение достаточно минималистичное, однако Вы можете создать столько заметок, сколько Вам потребуется, форматировать текст в них по своему усмотрению (для этого нужно выделить интересующий участок и выбрать атрибуты в появившемся контекстном меню), при необходимости - удалите замету свайпом влево, а еще Вы можете выбрать одну из двух тем оформления приложения. Заметки будут отсортированы по времени создания, самые свежие - вверху.\n\nПриятного использования!", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)])
			firstNote.date = Date()
			notes.append(firstNote)
			UserDefaults.standard.set(false, forKey: "FirstStart")
			return
		}
		let fetchRequest: NSFetchRequest<Note> = Note.fetchRequest()
		do {
			if let context = context {
				notes = try context.fetch(fetchRequest)
			}
		} catch {
			print(error.localizedDescription)
		}
		sort()
	}
	
	func saveData() {
		if context.hasChanges {
			DispatchQueue.global().async { [weak self] in
				do {
					try self?.context.save()
				} catch {
					print(error.localizedDescription)
				}
			}
			sort()
		}
	}
	
	func addNote(_ newNote: Note) {
		notes.append(newNote)
		saveData()
	}
	
	func getNote(for indexPath: IndexPath) -> Note {
		let index = getIndex(by: indexPath)
		return notes[index]
	}
	
	func removeNote(at indexPath: IndexPath) {
		let index = getIndex(by: indexPath)
		guard let title = notes[index].title,
			  let date = notes[index].date
		else { return }
		
		let fetchRequest: NSFetchRequest<Note> = Note.fetchRequest()
		fetchRequest.predicate = NSPredicate(format: "title == %@ AND date == %@", title, date as CVarArg)
		
		if let objects = try? context?.fetch(fetchRequest) {
			for object in objects {
				context?.delete(object)
			}
		}
		notes.remove(at: index)
		saveData()
	}
	
	private func getIndex(by indexPath: IndexPath) -> Int {
		return notesCount - 1 - indexPath.row
	}
	
	private func sort() {
		notes.sort { (lhs, rhs) -> Bool in
			guard let ldate = lhs.date,
				  let rdate = rhs.date else { return false }
			return ldate <= rdate
		}
	}
	
}

//MARK: - TableView data source
extension NotesDataManager: UITableViewDataSource {
	
	var cellReuseIdentifier: String { return "NoteCell" }
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return notes.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as? NoteCell else { return UITableViewCell() }
		
		let index = getIndex(by: indexPath)
		let note = notes[index]
		cell.configure(with: note)
		
		return cell
	}
}
