//
//  GameViewControllerView.swift
//  SwiftTickTackToe
//
//  Created by Андрей Щекатунов on 11.10.2021.
//

import UIKit

protocol GameViewControllerViewDelegate: AnyObject {
	func restartGame()
}

class GameViewControllerView: UIView {

	weak var delegate: GameViewControllerViewDelegate?

	private(set) lazy var firstPlayerLable: UILabel = {
		let text = UILabel()
		text.translatesAutoresizingMaskIntoConstraints = false
		text.textColor = .black
		text.textAlignment = .center
		text.font = UIFont.boldSystemFont(ofSize: 20.0)
		text.text = "1st player"
		return text
	}()

	private(set) lazy var secondPlayerLable: UILabel = {
		let text = UILabel()
		text.translatesAutoresizingMaskIntoConstraints = false
		text.textAlignment = .center
		text.textColor = .black
		text.font = UIFont.boldSystemFont(ofSize: 20.0)
		text.text = "2nd player"
		return text
	}()

	private(set) lazy var winLable: UILabel = {
		let text = UILabel()
		text.translatesAutoresizingMaskIntoConstraints = false
		text.textAlignment = .center
		text.textColor = .black
		text.font = UIFont.boldSystemFont(ofSize: 20.0)
		text.text = "win lable"
		return text
	}()

	private(set) lazy var restartButton: UIButton = {
		var button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.setTitle("Resturt", for: .normal)
		button.backgroundColor = .gray
		return button
	}()

	override init(frame: CGRect) {
		super.init(frame: frame)
		createSubviews()
		constraintsInit()
	}

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		createSubviews()
		constraintsInit()
	}

	func createSubviews() {
		backgroundColor = .white
		self.addSubview(firstPlayerLable)
		self.addSubview(winLable)
		self.addSubview(secondPlayerLable)
		self.addSubview(restartButton)
		restartButton.addTarget(self,
							   action: #selector(handleRestartGameTouchUpInseide),
							   for: .touchUpInside)
	}

	func constraintsInit() {
		NSLayoutConstraint.activate([

			firstPlayerLable.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20.0),
			firstPlayerLable.trailingAnchor.constraint(equalTo: self.centerXAnchor),
			firstPlayerLable.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20.0),
			firstPlayerLable.heightAnchor.constraint(equalToConstant: 40.0),

			secondPlayerLable.leadingAnchor.constraint(equalTo: self.centerXAnchor),
			secondPlayerLable.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20.0),
			secondPlayerLable.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20.0),
			secondPlayerLable.heightAnchor.constraint(equalToConstant: 40.0),

			winLable.centerXAnchor.constraint(equalTo: self.centerXAnchor),
			winLable.topAnchor.constraint(equalTo: self.firstPlayerLable.bottomAnchor, constant: 5.0),
			winLable.heightAnchor.constraint(equalToConstant: 40.0),

			restartButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 80.0),
			restartButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -80.0),
			restartButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -40.0),
			restartButton.heightAnchor.constraint(equalToConstant: 40.0)
		])
	}

	@objc func handleRestartGameTouchUpInseide() {
		delegate?.restartGame()
	}
}
