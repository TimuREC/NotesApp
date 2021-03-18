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
    
	func configure(with note: Note) {
		titleLabel.text = note.title
		if let date = note.date {
			let dateFormatter = DateFormatter()
			let calendar = Calendar.current
			let dateComponents = calendar.dateComponents([.year, .month, .day], from: date)
			let nowComponents = calendar.dateComponents([.year, .month, .day], from: Date())
			
			if let dateYear = dateComponents.year, let dateMonth = dateComponents.month, let dateDay = dateComponents.day,
			   let nowYear = nowComponents.year, let nowMonth = nowComponents.month, let nowDay = nowComponents.day {
				if dateYear < nowYear || dateMonth < nowMonth || dateDay < nowDay {
					dateFormatter.dateFormat = "dd.MM.yy"
				} else {
					dateFormatter.dateFormat = "HH:mm"
				}
			}
			dateLabel.text = dateFormatter.string(from: date)
		}
	}

}
