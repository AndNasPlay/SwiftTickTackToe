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
	func selectComplexity(_ sender: UISegmentedControl)
}

class MainViewControllerView: UIView {

	weak var delegate: MainViewControllerViewDelegate?

	private(set) lazy var stackViewbuttonSpacing: CGFloat = 20.0

	private(set) lazy var leadingTrailingAnchorStackView: CGFloat = 60.0

	private(set) lazy var leadingTrailingAnchorLogo: CGFloat = 80.0

	private(set) lazy var logoHeightAnchor: CGFloat = 100.0

	private(set) lazy var leadingTrailingAnchorSwitcher: CGFloat = 150.0

	private(set) lazy var switcherHeightAnchor: CGFloat = 40.0

	private(set) lazy var centerYAnchorStackViewIndent: CGFloat = 20.0

	private(set) lazy var stackViewHeightAnchor: CGFloat = 140.0

	private(set) lazy var buttonsFontSize: CGFloat = 20.0

	private(set) lazy var logoImageViewHeightAnchor: CGFloat = 95.0

	private(set) lazy var logoImageViewWidthAnchor: CGFloat = 210.0

	private(set) lazy var complexitySwitchAnchors: CGFloat = 5.0

	private(set) lazy var logoImageView: UIImageView = {
		var img = UIImageView()
		img.translatesAutoresizingMaskIntoConstraints = false
		img.image = UIImage(named: "logo")
		img.backgroundColor = .clear
		return img
	}()

	private(set) lazy var singlePlayer: UIButton = {
		var button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.setTitle("SINGLE PLAYER", for: .normal)
		button.setTitleColor(.buttonTextColorNormal, for: .normal)
		button.setTitleColor(.buttonTextColorHighlighted, for: .highlighted)
		button.titleLabel?.font = UIFont.systemFont(ofSize: buttonsFontSize, weight: .semibold)
		button.backgroundColor = .buttonsAndOViewColor
		button.layer.cornerRadius = (stackViewHeightAnchor - stackViewbuttonSpacing) / 4
		return button
	}()

	private(set) lazy var multiplayerButton: UIButton = {
		var button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.setTitle("MULTIPLAYER", for: .normal)
		button.setTitleColor(.buttonTextColorNormal, for: .normal)
		button.setTitleColor(.buttonTextColorHighlighted, for: .highlighted)
		button.titleLabel?.font = UIFont.systemFont(ofSize: buttonsFontSize, weight: .semibold)
		button.backgroundColor = .buttonsAndOViewColor
		button.layer.cornerRadius = (stackViewHeightAnchor - stackViewbuttonSpacing) / 4
		return button
	}()

	private(set) lazy var complexitySwitch: UISegmentedControl = {
		let items = ["EASY", "HARD"]
		var switcher = UISegmentedControl(items: items)
		switcher.translatesAutoresizingMaskIntoConstraints = false
		switcher.selectedSegmentIndex = 0
		switcher.selectedSegmentTintColor = .complexityOnBg
		switcher.backgroundColor = .complexityOffBg
		switcher.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
		switcher.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
		return switcher
	}()

	private(set) lazy var complexityUIVIew: UIView = {
		var switcher = UIView()
		switcher.translatesAutoresizingMaskIntoConstraints = false
		switcher.layer.cornerRadius = switcherHeightAnchor / 2
		switcher.layer.borderColor = UIColor.clear.cgColor
		switcher.layer.masksToBounds = true
		return switcher
	}()

	private(set) lazy var buttonsStackView: UIStackView = {
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
		self.addSubview(buttonsStackView)
		self.addSubview(logoImageView)
		self.addSubview(complexityUIVIew)
		self.complexityUIVIew.addSubview(complexitySwitch)
		buttonsStackView.addArrangedSubview(multiplayerButton)
		buttonsStackView.addArrangedSubview(singlePlayer)
		singlePlayer.addTarget(self,
							   action: #selector(handlePlaySinglePlayerTouchUpInseide),
							   for: .touchUpInside)
		multiplayerButton.addTarget(self,
									action: #selector(handlePlayMultiplayerTouchUpInseide),
									for: .touchUpInside)
		complexitySwitch.addTarget(self,
								   action: #selector(handleSelectComplexity(_:)),
								   for: .valueChanged)
	}

	func constraintsInit() {
		NSLayoutConstraint.activate([

			logoImageView.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
			logoImageView.widthAnchor.constraint(equalToConstant: logoImageViewWidthAnchor),
			logoImageView.heightAnchor.constraint(equalToConstant: logoImageViewHeightAnchor),
			logoImageView.bottomAnchor.constraint(equalTo: self.centerYAnchor, constant: -centerYAnchorStackViewIndent),

			buttonsStackView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor,
													  constant: leadingTrailingAnchorStackView),
			buttonsStackView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor,
													   constant: -leadingTrailingAnchorStackView),
			buttonsStackView.topAnchor.constraint(equalTo: self.centerYAnchor,
												  constant: centerYAnchorStackViewIndent),
			buttonsStackView.heightAnchor.constraint(equalToConstant: stackViewHeightAnchor),

			complexityUIVIew.topAnchor.constraint(equalTo: self.buttonsStackView.bottomAnchor,
												  constant: centerYAnchorStackViewIndent),
			complexityUIVIew.centerXAnchor.constraint(equalTo: self.centerXAnchor),
			complexityUIVIew.heightAnchor.constraint(equalToConstant: switcherHeightAnchor),
			complexityUIVIew.widthAnchor.constraint(equalToConstant: leadingTrailingAnchorStackView * 2),

			complexitySwitch.leadingAnchor.constraint(equalTo: self.complexityUIVIew.leadingAnchor,
													  constant: -complexitySwitchAnchors),
			complexitySwitch.trailingAnchor.constraint(equalTo: self.complexityUIVIew.trailingAnchor,
													   constant: complexitySwitchAnchors),
			complexitySwitch.topAnchor.constraint(equalTo: self.complexityUIVIew.topAnchor,
												  constant: -complexitySwitchAnchors),
			complexitySwitch.bottomAnchor.constraint(equalTo: self.complexityUIVIew.bottomAnchor,
													 constant: complexitySwitchAnchors)
		])
	}

	@objc func handlePlayMultiplayerTouchUpInseide() {
		delegate?.playMultiplayerButton()
	}

	@objc func handlePlaySinglePlayerTouchUpInseide() {
		delegate?.playSinglePlayer()
	}

	@objc func handleSelectComplexity(_ sender: UISegmentedControl) {
		delegate?.selectComplexity(sender)
	}
}
