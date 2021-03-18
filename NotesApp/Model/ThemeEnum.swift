//
//  ThemeEnum.swift
//  NotesApp
//
//  Created by Timur Begishev on 18.03.2021.
//

import UIKit

enum Theme: Int, CaseIterable {
	case light, dark
}

extension Theme {
	
	var background: UIColor {
		switch self {
		case .light:
			return .white
		case .dark:
			return .black
		}
	}
	
	var textColor: UIColor {
		switch self {
		case .light:
			return .black
		case .dark:
			return .white
		}
	}
}
