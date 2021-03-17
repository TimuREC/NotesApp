//
//  NoteViewController.swift
//  NotesApp
//
//  Created by Timur Begishev on 17.03.2021.
//

import UIKit

class NoteViewController: UIViewController {
	
	private var note: Note? {
		willSet {
			guard let value = newValue else { return }
			title = value.title
			
			let dateFormatter = DateFormatter()
			dateFormatter.locale = Locale(identifier: "ru_Ru")
			dateFormatter.dateFormat = "dd MMMM yyyy' в 'HH:mm"
			dateLabel.text = dateFormatter.string(from: value.date)
		}
	}
	
	let dateLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont.systemFont(ofSize: 12)
		label.textColor = .gray
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	let textView: UITextView = {
		let textView = UITextView()
		textView.translatesAutoresizingMaskIntoConstraints = false
		textView.allowsEditingTextAttributes = true
		textView.isScrollEnabled = true
		textView.backgroundColor = .clear
		return textView
	}()

    override func viewDidLoad() {
        super.viewDidLoad()

		view.backgroundColor = .white
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
	
	func configure(with note: Note? = nil) {
		if let editingNote = note {
			self.note = editingNote
		} else {
			self.note = Note(title: "New Note", date: Date())
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
