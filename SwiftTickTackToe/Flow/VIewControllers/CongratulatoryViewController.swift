//
//  CongratulatoryViewController.swift
//  SwiftTickTackToe
//
//  Created by Андрей Щекатунов on 29.10.2021.
//

import UIKit

protocol CongratulatoryDelegate: AnyObject {
	func restart()
}

class CongratulatoryViewController: UIViewController, CongratulatoryViewControllerViewDelegate {

	var newView = CongratulatoryUIView()

	weak var delegate: CongratulatoryDelegate?

	private(set) lazy var newViewLeadingTrailingAnchor: CGFloat = 40.0

	private(set) lazy var newViewHeightAnchor: CGFloat = 360.0

	private(set) lazy var bgAlphaComponent: CGFloat = 0.4

    override func viewDidLoad() {
        super.viewDidLoad()
		self.view.backgroundColor = .gray.withAlphaComponent(bgAlphaComponent)
		self.view.addSubview(newView)
		newView.delegate = self
		constraintsInit()
    }

	func constraintsInit() {
		NSLayoutConstraint.activate([

			newView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,
											 constant: newViewLeadingTrailingAnchor),
			newView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,
											  constant: -newViewLeadingTrailingAnchor),
			newView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
			newView.heightAnchor.constraint(equalToConstant: newViewHeightAnchor)
		])
	}

	func done() {
		self.dismiss(animated: true) {
			self.delegate?.restart()
		}
	}
}
