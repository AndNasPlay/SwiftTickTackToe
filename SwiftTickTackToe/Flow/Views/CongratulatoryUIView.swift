//
//  CongratulatoryUIView.swift
//  SwiftTickTackToe
//
//  Created by Андрей Щекатунов on 29.10.2021.
//

import UIKit

protocol CongratulatoryViewControllerViewDelegate: AnyObject {
	func done()
}

class CongratulatoryUIView: UIView {

	weak var delegate: CongratulatoryViewControllerViewDelegate?

	private(set) lazy var stackViewbuttonSpacing: CGFloat = 20.0

	private(set) lazy var leadingTrailingAnchorStackView: CGFloat = 20.0

	private(set) lazy var leadingTrailingAnchorLogo: CGFloat = 40.0

	private(set) lazy var leadingTrailingAnchorWinLable: CGFloat = 40.0

	private(set) lazy var stackViewHeightAnchor: CGFloat = 60.0

	private(set) lazy var buttonFontSize: CGFloat = 25.0

	private(set) lazy var winLableTopAnchor: CGFloat = 20.0

	private(set) lazy var winLableHeightAnchor: CGFloat = 40.0

	private(set) lazy var logoImageViewDoneButtonTopAnchor: CGFloat = 40.0

	private(set) lazy var doneButtonBottomAnchor: CGFloat = 40.0

	private(set) lazy var winLable: UILabel = {
		let text = UILabel()
		text.translatesAutoresizingMaskIntoConstraints = false
		text.textColor = .buttonsAndOViewColor
		text.textAlignment = .center
		text.font = UIFont.boldSystemFont(ofSize: buttonFontSize)
		text.text = "YOU WIN!"
		return text
	}()

	private(set) lazy var logoImageView: UIImageView = {
		var img = UIImageView()
		img.translatesAutoresizingMaskIntoConstraints = false
		img.image = UIImage(named: "popupLogo")
		img.backgroundColor = .clear
		return img
	}()

	private(set) lazy var doneButton: UIButton = {
		var button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.setTitle("PLAY AGAIN", for: .normal)
		button.setTitleColor(.white, for: .normal)
		button.titleLabel?.font = UIFont.systemFont(ofSize: buttonFontSize)
		button.backgroundColor = .buttonsAndOViewColor
		button.layer.cornerRadius = stackViewHeightAnchor / 2
		return button
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
		self.addSubview(winLable)
		self.addSubview(doneButton)
		self.addSubview(logoImageView)
		doneButton.addTarget(self,
							   action: #selector(handleDoneTouchUpInseide),
							   for: .touchUpInside)
	}

	func constraintsInit() {
		NSLayoutConstraint.activate([

			winLable.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: winLableTopAnchor),
			winLable.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor,
												   constant: leadingTrailingAnchorWinLable),
			winLable.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor,
													constant: -leadingTrailingAnchorWinLable),
			winLable.heightAnchor.constraint(equalToConstant: winLableHeightAnchor),

			logoImageView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor,
												   constant: leadingTrailingAnchorLogo),
			logoImageView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor,
													constant: -leadingTrailingAnchorLogo),
			logoImageView.topAnchor.constraint(equalTo: self.winLable.bottomAnchor, constant: logoImageViewDoneButtonTopAnchor),

			doneButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor,
											   constant: leadingTrailingAnchorStackView),
			doneButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor,
												constant: -leadingTrailingAnchorStackView),
			doneButton.topAnchor.constraint(equalTo: self.logoImageView.bottomAnchor,
											constant: logoImageViewDoneButtonTopAnchor),
			doneButton.heightAnchor.constraint(equalToConstant: stackViewHeightAnchor),
			doneButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -doneButtonBottomAnchor)
		])
	}

	@objc func handleDoneTouchUpInseide() {
		delegate?.done()
	}
}
