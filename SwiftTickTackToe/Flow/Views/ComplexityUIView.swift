//
//  ComplexityUIView.swift
//  SwiftTickTackToe
//
//  Created by Андрей Щекатунов on 29.10.2021.
//

import UIKit

protocol ComplexityViewControllerViewDelegate: AnyObject {
	func easy()
	func hard()
}

class ComplexityUIView: UIView {

	weak var delegate: ComplexityViewControllerViewDelegate?

	private(set) lazy var stackViewbuttonSpacing: CGFloat = 20.0

	private(set) lazy var leadingTrailingAnchorStackView: CGFloat = 60.0

	private(set) lazy var stackViewHeightAnchor: CGFloat = 120.0

	private(set) lazy var buttonsFontSize: CGFloat = 20.0

	private(set) lazy var easyButton: UIButton = {
		var button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.setTitle("Easy", for: .normal)
		button.setTitleColor(.white, for: .normal)
		button.titleLabel?.font = UIFont.systemFont(ofSize: buttonsFontSize)
		button.backgroundColor = .buttonsAndOViewColor
		button.layer.cornerRadius = (stackViewHeightAnchor - stackViewbuttonSpacing) / 4
		return button
	}()

	private(set) lazy var hardButton: UIButton = {
		var button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.setTitle("Hard", for: .normal)
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
		self.translatesAutoresizingMaskIntoConstraints = false
		createSubviews()
		constraintsInit()
	}

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		self.translatesAutoresizingMaskIntoConstraints = false
		createSubviews()
		constraintsInit()
	}

	func createSubviews() {
		backgroundColor = .viewBackgroundColor
		self.layer.cornerRadius = 10
		self.addSubview(stackView)
		stackView.addArrangedSubview(easyButton)
		stackView.addArrangedSubview(hardButton)
		easyButton.addTarget(self,
							   action: #selector(handlePlayEastGameTouchUpInseide),
							   for: .touchUpInside)
		hardButton.addTarget(self,
									action: #selector(handlePlayHardGameTouchUpInseide),
									for: .touchUpInside)
	}

	func constraintsInit() {
		NSLayoutConstraint.activate([

			stackView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor,
											   constant: leadingTrailingAnchorStackView),
			stackView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor,
												constant: -leadingTrailingAnchorStackView),
			stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
			stackView.heightAnchor.constraint(equalToConstant: stackViewHeightAnchor)

		])
	}

	@objc func handlePlayEastGameTouchUpInseide() {
		delegate?.easy()
	}

	@objc func handlePlayHardGameTouchUpInseide() {
		delegate?.hard()
	}
}
