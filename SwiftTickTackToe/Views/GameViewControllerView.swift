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

	private(set) lazy var leadingTrailingLableAnchor: CGFloat = 20.0

	private(set) lazy var topLableHeightAnchor: CGFloat = 40.0

	private(set) lazy var topLableAnchor: CGFloat = 20.0

	private(set) lazy var lableUIFontSize: CGFloat = 20.0

	private(set) lazy var leadingTrailingRestartButtonAnchor: CGFloat = 80.0

	private(set) lazy var firstPlayerLable: UILabel = {
		let text = UILabel()
		text.translatesAutoresizingMaskIntoConstraints = false
		text.textColor = .black
		text.textAlignment = .center
		text.font = UIFont.boldSystemFont(ofSize: lableUIFontSize)
		text.text = "1st player"
		return text
	}()

	private(set) lazy var secondPlayerLable: UILabel = {
		let text = UILabel()
		text.translatesAutoresizingMaskIntoConstraints = false
		text.textAlignment = .center
		text.textColor = .black
		text.font = UIFont.boldSystemFont(ofSize: lableUIFontSize)
		text.text = "2nd player"
		return text
	}()

	private(set) lazy var winLable: UILabel = {
		let text = UILabel()
		text.translatesAutoresizingMaskIntoConstraints = false
		text.textAlignment = .center
		text.textColor = .black
		text.font = UIFont.boldSystemFont(ofSize: lableUIFontSize)
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

			firstPlayerLable.leadingAnchor.constraint(
				equalTo: self.safeAreaLayoutGuide.leadingAnchor,
				constant: leadingTrailingLableAnchor),
			firstPlayerLable.trailingAnchor.constraint(equalTo: self.centerXAnchor),
			firstPlayerLable.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: topLableAnchor),
			firstPlayerLable.heightAnchor.constraint(equalToConstant: topLableHeightAnchor),

			secondPlayerLable.leadingAnchor.constraint(equalTo: self.centerXAnchor),
			secondPlayerLable.trailingAnchor.constraint(
				equalTo: self.safeAreaLayoutGuide.trailingAnchor,
				constant: -leadingTrailingLableAnchor),
			secondPlayerLable.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: topLableAnchor),
			secondPlayerLable.heightAnchor.constraint(equalToConstant: topLableHeightAnchor),

			winLable.centerXAnchor.constraint(equalTo: self.centerXAnchor),
			winLable.topAnchor.constraint(equalTo: self.firstPlayerLable.bottomAnchor, constant: topLableAnchor),
			winLable.heightAnchor.constraint(equalToConstant: topLableHeightAnchor),

			restartButton.leadingAnchor.constraint(
				equalTo: self.safeAreaLayoutGuide.leadingAnchor,
				constant: leadingTrailingRestartButtonAnchor),
			restartButton.trailingAnchor.constraint(
				equalTo: self.safeAreaLayoutGuide.trailingAnchor,
				constant: -leadingTrailingRestartButtonAnchor),
			restartButton.heightAnchor.constraint(equalToConstant: 60.0)
		])
	}

	@objc func handleRestartGameTouchUpInseide() {
		delegate?.restartGame()
	}
}
