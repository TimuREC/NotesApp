//
//  ViewController.swift
//  NotesApp
//
//  Created by Timur Begishev on 17.03.2021.
//

import UIKit

class NotesListViewController: UITableViewController {
	
	private let notesManager = NotesDataManager()

	override func viewDidLoad() {
		super.viewDidLoad()
		tableView.dataSource = notesManager
		tableView.separatorInset = .zero
		title = "My Notes"
		
		navigationItem.rightBarButtonItem = configureNewNoteButton()
		
		tableView.register(NoteCell.self, forCellReuseIdentifier: notesManager.cellReuseIdentifier)
		tableView.tableFooterView = UIView()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		tableView.reloadData()
	}
	
	private func configureNewNoteButton() -> UIBarButtonItem {
		let settingsImage = UIImage(named: "Plus")
		let button = UIButton(type: .system)
		button.setImage(settingsImage, for: .normal)
		button.addTarget(self, action: #selector(addNewNote), for: .touchUpInside)

		let menuBarItem = UIBarButtonItem(customView: button)
		if let view = menuBarItem.customView {
			view.translatesAutoresizingMaskIntoConstraints = false
			NSLayoutConstraint.activate([
				view.heightAnchor.constraint(equalToConstant: 20),
				view.widthAnchor.constraint(equalTo: view.heightAnchor)
			])
		}

		return menuBarItem
	}
	
	// MARK: - Interactions
	@objc
	private func addNewNote() {
		let targetVC = NoteViewController()
		
		targetVC.configure(notesManager: notesManager)
		navigationController?.pushViewController(targetVC, animated: true)
	}
	
	private func removeAction(at indexPath: IndexPath) -> UIContextualAction {
		let action = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (_, _, completion) in
			
			self?.notesManager.removeNote(at: indexPath)
			self?.tableView.deleteRows(at: [indexPath], with: .automatic)
			completion(true)
		}
		return action
	}
	
	// MARK: - TableView delegate methods
	override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
		let remove = removeAction(at: indexPath)
		return UISwipeActionsConfiguration(actions: [remove])
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		
		let targetVC = NoteViewController()
		
		let note = notesManager.getNote(for: indexPath)
		targetVC.configure(with: note, notesManager: notesManager)
		
		navigationController?.pushViewController(targetVC, animated: true)
	}
	
	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 55
	}

}

