//
//  ComplexityViewController.swift
//  SwiftTickTackToe
//
//  Created by Андрей Щекатунов on 29.10.2021.
//

import UIKit

class ComplexityViewController: UIViewController, ComplexityViewControllerViewDelegate {

	var newView = ComplexityUIView()

	func easy() {
		self.navigationController?.pushViewController(GameViewController(
														gameMode: .singlePlayer,
														complexity: .easy),
													  animated: true)
	}

	func hard() {
		self.navigationController?.pushViewController(GameViewController(
														gameMode: .singlePlayer,
														complexity: .hard),
													  animated: true)
	}

    override func viewDidLoad() {
        super.viewDidLoad()
		self.view.layer.shadowColor = UIColor.black.cgColor
		self.view.layer.shadowRadius = 20
		self.view.layer.shadowOpacity = 1
		self.view.layer.shadowOffset = .zero
		self.view.backgroundColor = .lightGray
		self.view.addSubview(newView)
		newView.delegate = self
		constraintsInit()
    }

	func constraintsInit() {
		NSLayoutConstraint.activate([

			newView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,
											 constant: 20.0),
			newView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,
											  constant: -20.0),
			newView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
			newView.heightAnchor.constraint(equalToConstant: 300)
		])
	}

}
