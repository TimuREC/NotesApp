//
//  SettingsViewController.swift
//  NotesApp
//
//  Created by Timur Begishev on 17.03.2021.
//

import UIKit

class SettingsViewController: UIViewController {
	
	private let examplesStackView: UIStackView = {
		let stackView = UIStackView()
		stackView.axis = .vertical
		stackView.distribution = .fillEqually
		stackView.spacing = 40
		stackView.translatesAutoresizingMaskIntoConstraints = false
		return stackView
	}()

    override func viewDidLoad() {
        super.viewDidLoad()
		view.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
		
		view.addSubview(examplesStackView)
		for theme in Theme.allCases {
			let themeView = ThemeView(theme: theme)
			let tap = UITapGestureRecognizer(target: self, action: #selector(themeSelected))
			themeView.addGestureRecognizer(tap)
			themeView.isSelected = (theme == ThemeService.activeTheme)
			examplesStackView.addArrangedSubview(themeView)
		}
		
		NSLayoutConstraint.activate([
			examplesStackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
			examplesStackView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
			examplesStackView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
			examplesStackView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
		])
    }
	
	@objc
	func themeSelected(sender: UITapGestureRecognizer) {
		guard let view = sender.view as? ThemeView,
			  view.isSelected == false
		else { return }
		ThemeService.selectTheme(view.theme)
		examplesStackView.arrangedSubviews.forEach { ($0 as? ThemeView)?.isSelected = false }
		view.isSelected = true
		ThemeService.applyTheme()
		let window = UIApplication.shared.keyWindow
		window?.rootViewController?.setNeedsStatusBarAppearanceUpdate()
		if let rootVC = (window?.rootViewController as? MainNavigationController)?.viewControllers.first as? NotesListViewController {
			rootVC.tableView.reloadData()
		}
		window?.subviews.forEach { view in
			view.removeFromSuperview()
			window?.addSubview(view)
		}
	}

}
