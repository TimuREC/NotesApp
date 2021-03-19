//
//  NoteViewController.swift
//  NotesApp
//
//  Created by Timur Begishev on 17.03.2021.
//

import UIKit

class NoteViewController: UIViewController {
	
	private weak var notesManager: NotesDataManager?
	
	private var isNew = false
	
	private var note: Note! {
		willSet {
			guard let newValue = newValue else { return }
			title = newValue.title
			textView.attributedText = newValue.text
			
			let dateFormatter = DateFormatter()
			dateFormatter.locale = Locale(identifier: "ru_Ru")
			dateFormatter.dateFormat = "dd MMMM yyyy' в 'HH:mm"
			dateLabel.text = dateFormatter.string(from: newValue.date ?? Date())
		}
	}
	
	private let dateLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont.systemFont(ofSize: 12)
		label.textColor = .gray
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	private let textView: UITextView = {
		let textView = UITextView()
		textView.font = UIFont.systemFont(ofSize: 16)
		textView.translatesAutoresizingMaskIntoConstraints = false
		textView.allowsEditingTextAttributes = true
		textView.isScrollEnabled = true
		textView.alwaysBounceVertical = true
		return textView
	}()

    override func viewDidLoad() {
        super.viewDidLoad()

		view.backgroundColor = ThemeService.activeTheme.background
		view.addSubview(dateLabel)
		view.addSubview(textView)
		addKeyboardObservers()
    }
	
	override func viewWillLayoutSubviews() {
		NSLayoutConstraint.activate([
			dateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			dateLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
			dateLabel.widthAnchor.constraint(lessThanOrEqualTo: view.widthAnchor, multiplier: 0.7),
			textView.topAnchor.constraint(lessThanOrEqualTo: dateLabel.bottomAnchor, constant: 5),
			textView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			textView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			textView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
		])
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		if let text = textView.attributedText, !text.string.isEmpty && note.text != text {
			note?.title = text.string.components(separatedBy: "\n").first
			note?.text = text
			note?.date = Date()
			if isNew {
				notesManager?.addNote(note)
			} else {
				notesManager?.saveData()
			}
		}
	}
	
	func configure(with note: Note? = nil, notesManager: NotesDataManager) {
		self.notesManager = notesManager
		if let note = note {
			self.note = note
		} else {
			self.note = Note(context: notesManager.context)
			title = "New Note"
			isNew = true
		}
	}
	
	private func addKeyboardObservers() {
		NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: UIResponder.keyboardWillShowNotification, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: UIResponder.keyboardWillHideNotification, object: nil)
	}
	
	@objc
	private func handleKeyboardNotification(notification: NSNotification) {
		if let userInfo = notification.userInfo,
		   let value = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
			let keyboardFrame = value.cgRectValue
			
			if notification.name == UIResponder.keyboardWillShowNotification {
				textView.contentInset.bottom = keyboardFrame.height
			} else {
				textView.contentInset.bottom = .zero
			}
		}
	}

}
