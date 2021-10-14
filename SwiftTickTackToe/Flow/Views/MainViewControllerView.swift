//
//  MainViewControllerView.swift
//  SwiftTickTackToe
//
//  Created by Андрей Щекатунов on 11.10.2021.
//

import UIKit

protocol MainViewControllerViewDelegate: AnyObject {
	func playSinglePlayer()
	func playMultiplayerButton()
}

class MainViewControllerView: UIView {

	weak var delegate: MainViewControllerViewDelegate?

	private(set) lazy var stackViewbuttonSpacing: CGFloat = 20.0

	private(set) lazy var leadingTrailingAnchorStackView: CGFloat = 40.0

	private(set) lazy var centerYAnchorStackViewIndent: CGFloat = 70.0

	private(set) lazy var stackViewHeightAnchor: CGFloat = 170.0

	private(set) lazy var buttonsFontSize: CGFloat = 30.0

	private(set) lazy var singlePlayer: UIButton = {
		var button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.setTitle("Single player", for: .normal)
		button.setTitleColor(.white, for: .normal)
		button.titleLabel?.font = UIFont.systemFont(ofSize: buttonsFontSize)
		button.backgroundColor = .buttonsAndOViewColor
		button.layer.cornerRadius = (stackViewHeightAnchor - stackViewbuttonSpacing) / 4
		return button
	}()

	private(set) lazy var multiplayerButton: UIButton = {
		var button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.setTitle("Multiplayer", for: .normal)
		button.setTitleColor(.white, for: .normal)
		button.titleLabel?.font = UIFont.systemFont(ofSize: buttonsFontSize)
		button.backgroundColor = .buttonsAndOViewColor
		button.layer.cornerRadius = (stackViewHeightAnchor - stackViewbuttonSpacing) / 4
		return button
	}()

	private(set) lazy var stackView: UIStackView = {
		var stackView = UIStackView()
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.axis = .vertical
		stackView.alignment = .fill
		stackView.spacing = stackViewbuttonSpacing
		stackView.distribution = .fillEqually
		return stackView
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
		backgroundColor = .viewBackgroundColor
		self.addSubview(stackView)
		stackView.addArrangedSubview(singlePlayer)
		stackView.addArrangedSubview(multiplayerButton)
		singlePlayer.addTarget(self,
							   action: #selector(handlePlayMultiplayerTouchUpInseide),
							   for: .touchUpInside)
		multiplayerButton.addTarget(self,
									action: #selector(handlePlaySinglePlayerTouchUpInseide),
									for: .touchUpInside)
	}

	func constraintsInit() {
		NSLayoutConstraint.activate([

			stackView.leadingAnchor.constraint(
				equalTo: self.safeAreaLayoutGuide.leadingAnchor,
				constant: leadingTrailingAnchorStackView),
			stackView.trailingAnchor.constraint(
				equalTo: self.safeAreaLayoutGuide.trailingAnchor,
				constant: -leadingTrailingAnchorStackView),
			stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: centerYAnchorStackViewIndent),
			stackView.heightAnchor.constraint(equalToConstant: stackViewHeightAnchor)

		])
	}

	@objc func handlePlayMultiplayerTouchUpInseide() {
		delegate?.playMultiplayerButton()
	}

	@objc func handlePlaySinglePlayerTouchUpInseide() {
		delegate?.playSinglePlayer()
	}
}