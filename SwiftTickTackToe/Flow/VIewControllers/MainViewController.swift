//
//  MainViewController.swift
//  SwiftTickTackToe
//
//  Created by Андрей Щекатунов on 11.10.2021.
//

import UIKit

class MainViewController: UIViewController, MainViewControllerViewDelegate {

	var newView = MainViewControllerView()

	override func loadView() {
		newView.delegate = self
		view = newView
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		navigationController?.navigationBar.isHidden = true
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(true)
		navigationController?.navigationBar.isHidden = true
	}

	func playSinglePlayer() {
		self.navigationController?.pushViewController(SingleGameViewController(gameMode: .singlePlayer), animated: true)
	}

	func playMultiplayerButton() {
		self.navigationController?.pushViewController(GameViewController(gameMode: .multiplayer), animated: true)
	}
}
