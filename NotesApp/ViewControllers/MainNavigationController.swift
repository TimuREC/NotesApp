//
//  MainNavigationController.swift
//  NotesApp
//
//  Created by Timur Begishev on 17.03.2021.
//

import UIKit

class MainNavigationController: UINavigationController {
	
	override var preferredStatusBarStyle: UIStatusBarStyle {
		return ThemeService.activeTheme.statusBar
	}

    override func viewDidLoad() {
        super.viewDidLoad()
		
		let rootVC = NotesListViewController()
		
		let backButton = UIBarButtonItem(title: nil, style: .plain, target: self, action: nil)
		rootVC.navigationItem.backBarButtonItem = backButton
		
		rootVC.navigationItem.leftBarButtonItem = configureSettingsButton()
		
		setViewControllers([rootVC], animated: false)
    }
	
	private func configureSettingsButton() -> UIBarButtonItem {
		let settingsImage = UIImage(named: "Settings")
		let button = UIButton(type: .system)
		button.setImage(settingsImage, for: .normal)
		button.addTarget(self, action: #selector(openSettingsViewController), for: .touchUpInside)

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
	
	@objc
	private func openSettingsViewController() {
		let settingsVC = SettingsViewController()
		settingsVC.title = "Settings"
		
		pushViewController(settingsVC, animated: true)
	}
}
