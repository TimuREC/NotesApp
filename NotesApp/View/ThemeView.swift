//
//  ThemeView.swift
//  NotesApp
//
//  Created by Timur Begishev on 18.03.2021.
//

import UIKit

class ThemeView: UIView {
	
	var theme: Theme
	
	var isSelected: Bool {
		didSet {
			layer.borderColor = isSelected ? UIColor.darkGray.cgColor : UIColor.gray.cgColor
		}
	}
	
	private let textLabel: UILabel = {
		let label = UILabel()
		label.text = "Так будет выглядеть текст"
		label.font = UIFont.systemFont(ofSize: 12)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()

	init(theme: Theme) {
		self.theme = theme
		isSelected = false
		super.init(frame: .zero)
		layer.borderWidth = 2
		backgroundColor = theme.background
		textLabel.textColor = theme.textColor
		addSubview(textLabel)
		NSLayoutConstraint.activate([
			textLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
			textLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
			textLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -5)
		])
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}
