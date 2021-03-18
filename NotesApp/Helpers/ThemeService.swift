//
//  ThemeService.swift
//  NotesApp
//
//  Created by Timur Begishev on 18.03.2021.
//

import UIKit

fileprivate let preferredThemeKey = "PreferredTheme"

class ThemeService {
	
	static var activeTheme: Theme {
		let val = UserDefaults.standard.integer(forKey: preferredThemeKey)
		return Theme(rawValue: val) ?? .light
	}
	
	static func selectTheme(_ theme: Theme) {
		UserDefaults.standard.setValue(theme.rawValue, forKey: preferredThemeKey)
	}
	
	static func applyTheme() {
		UINavigationBar.appearance().barTintColor = activeTheme.background
		UINavigationBar.appearance().titleTextAttributes = [.foregroundColor : activeTheme.textColor]
		UITableView.appearance().backgroundColor = activeTheme.background
		UITextView.appearance().backgroundColor = activeTheme.background
		UITextView.appearance().textColor = activeTheme.textColor
	}
	
}
