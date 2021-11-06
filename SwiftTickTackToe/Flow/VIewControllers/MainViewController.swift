//
//  MainViewController.swift
//  SwiftTickTackToe
//
//  Created by Андрей Щекатунов on 11.10.2021.
//

import UIKit
import AVFoundation

class MainViewController: UIViewController, MainViewControllerViewDelegate {

	var newView = MainViewControllerView()

	var complexity: SinglePlayerGameComplexity = .easy

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
		self.navigationController?.pushViewController(GameViewController(
														gameMode: .singlePlayer,
														complexity: complexity),
													  animated: true)
	}

	func playMultiplayerButton() {
		self.navigationController?.pushViewController(GameViewController(
														gameMode: .multiplayer,
														complexity: complexity),
													  animated: true)
	}

	func selectComplexity(_ sender: UISegmentedControl) {
		switch sender.selectedSegmentIndex {
		case 0:
			complexity = .easy
		case 1:
			complexity = .hard
		default:
			complexity = .easy
		}
	}
}
