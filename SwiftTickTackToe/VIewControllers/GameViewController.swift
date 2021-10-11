//
//  GameViewController.swift
//  SwiftTickTackToe
//
//  Created by Андрей Щекатунов on 11.10.2021.
//

import UIKit

class GameViewController: UIViewController {

	var newView: UIView = GameViewControllerView()

	override func viewDidLoad() {
		super.viewDidLoad()
		view = newView
	}
}

