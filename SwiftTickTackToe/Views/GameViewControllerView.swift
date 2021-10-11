//
//  GameViewControllerView.swift
//  SwiftTickTackToe
//
//  Created by Андрей Щекатунов on 11.10.2021.
//

import UIKit

class GameViewControllerView: UIView {

	private(set) lazy var firstPlayerLable: UILabel = {
		let text = UILabel()
		text.translatesAutoresizingMaskIntoConstraints = false
		text.textColor = .black
		text.textAlignment = .center
		text.font = UIFont.boldSystemFont(ofSize: 30.0)
		text.text = "1st player"
		return text
	}()

	private(set) lazy var secondPlayerLable: UILabel = {
		let text = UILabel()
		text.translatesAutoresizingMaskIntoConstraints = false
		text.textAlignment = .center
		text.textColor = .black
		text.font = UIFont.boldSystemFont(ofSize: 30.0)
		text.text = "2nd player"
		return text
	}()

	private(set) lazy var winLable: UILabel = {
		let text = UILabel()
		text.translatesAutoresizingMaskIntoConstraints = false
		text.textAlignment = .center
		text.textColor = .black
		text.font = UIFont.boldSystemFont(ofSize: 30.0)
		text.text = "win lable"
		return text
	}()

	private(set) lazy var restartButton: UIButton = {
		var button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.titleLabel?.text = "Resturt"
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
		backgroundColor = .red
		self.addSubview(firstPlayerLable)
//		self.addSubview(winLable)
//		self.addSubview(secondPlayerLable)
//		self.addSubview(restartButton)
	}

	func constraintsInit() {
		NSLayoutConstraint.activate([

			firstPlayerLable.centerYAnchor.constraint(equalTo: self.centerYAnchor),
			firstPlayerLable.centerXAnchor.constraint(equalTo: self.centerXAnchor),
			firstPlayerLable.heightAnchor.constraint(equalToConstant: 200.0),
			firstPlayerLable.widthAnchor.constraint(equalToConstant: 200.0),


//			firstPlayerLable.topAnchor.constraint(equalTo: self.topAnchor, constant: 50.0),
//			firstPlayerLable.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20.0),
//			firstPlayerLable.trailingAnchor.constraint(equalTo: self.centerXAnchor, constant: -20.0),
//			firstPlayerLable.bottomAnchor.constraint(equalTo: self.centerYAnchor, constant: -100.0),

//			secondPlayerLable.topAnchor.constraint(equalTo: self.topAnchor, constant: 50.0),
//			secondPlayerLable.leadingAnchor.constraint(equalTo: self.centerXAnchor, constant: 20.0),
//			secondPlayerLable.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20.0),
//			secondPlayerLable.bottomAnchor.constraint(equalTo: self.centerYAnchor, constant: -100.0),
//
//			winLable.topAnchor.constraint(equalTo: self.firstPlayerLable.bottomAnchor, constant: 50.0),
//			winLable.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20.0),
//			winLable.trailingAnchor.constraint(equalTo: self.centerXAnchor, constant: -20.0),
//			winLable.bottomAnchor.constraint(equalTo: self.centerYAnchor, constant: -100.0),
//
//			restartButton.topAnchor.constraint(equalTo: self.centerYAnchor, constant: -100.0),
//			restartButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20.0),
//			restartButton.trailingAnchor.constraint(equalTo: self.centerXAnchor, constant: -20.0),
//			restartButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 100.0),

		])
	}
}
