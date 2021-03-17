//
//  NoteCell.swift
//  NotesApp
//
//  Created by Timur Begishev on 17.03.2021.
//

import UIKit

class NoteCell: UITableViewCell {

	let titleLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont.systemFont(ofSize: 14)
		label.numberOfLines = 2
		return label
	}()
	
	let dateLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont.systemFont(ofSize: 12)
		label.textColor = .gray
		label.textAlignment = .right
		return label
	}()
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setupContent()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func setupContent() {
		let stack = UIStackView(arrangedSubviews: [titleLabel, dateLabel])
		stack.distribution = .fill
		stack.axis = .vertical
		stack.spacing = 5
		
		stack.translatesAutoresizingMaskIntoConstraints = false
		contentView.addSubview(stack)
		NSLayoutConstraint.activate([
			stack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
			stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
			stack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
			stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
		])
	}
    
	func configure(with note: Note) { // NoteCellConfiguration
		titleLabel.text = note.title
	}

}
