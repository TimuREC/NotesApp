//
//  MainNavigationController.swift
//  NotesApp
//
//  Created by Timur Begishev on 17.03.2021.
//

import UIKit

class MainNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
		
		let rootVC = NotesListViewController()
		
		let backButton = UIBarButtonItem(title: nil, style: .plain, target: self, action: nil)
		rootVC.navigationItem.backBarButtonItem = backButton
		
		rootVC.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Settings",
														   style: .plain,
														   target: self,
														   action: #selector(openSettingsViewController))
		
		setViewControllers([rootVC], animated: false)
    }
	
	@objc
	private func openSettingsViewController() {
		let settingsVC = SettingsViewController()
		settingsVC.title = "Settings"
		
		pushViewController(settingsVC, animated: true)
	}
	

}
