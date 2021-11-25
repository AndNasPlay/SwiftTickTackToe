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

	private(set) lazy var leadingTrailingAnchorStackView: CGFloat = 20.0

	private(set) lazy var leadingTrailingAnchorWinLable: CGFloat = 40.0

	private(set) lazy var stackViewHeightAnchor: CGFloat = 60.0

	private(set) lazy var buttonFontSize: CGFloat = 25.0

	private(set) lazy var winLableLogoTopAnchor: CGFloat = 40.0

	private(set) lazy var winLableHeightAnchor: CGFloat = 25.0

	private(set) lazy var doneButtonBottomAnchor: CGFloat = 20.0

	private(set) lazy var logoImageTopAnchor: CGFloat = 30.0

	private(set) lazy var logoImageViewHeightAnchor: CGFloat = 150.0

	private(set) lazy var logoImageViewWidthAnchor: CGFloat = 180.0

	private(set) lazy var mainViewcornerRadius: CGFloat = 10.0

	private(set) lazy var winLable: UILabel = {
		let text = UILabel()
		text.translatesAutoresizingMaskIntoConstraints = false
		text.textColor = .buttonsAndOViewColor
		text.textAlignment = .center
		text.font = UIFont.boldSystemFont(ofSize: buttonFontSize)
		text.text = "YOU WON!"
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
		button.setTitleColor(.buttonTextColorNormal, for: .normal)
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
		self.layer.cornerRadius = mainViewcornerRadius
		self.addSubview(winLable)
		self.addSubview(doneButton)
		self.addSubview(logoImageView)
		doneButton.addTarget(self,
							   action: #selector(handleDoneTouchUpInseide),
							   for: .touchUpInside)
	}

	func constraintsInit() {
		NSLayoutConstraint.activate([

			winLable.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: winLableLogoTopAnchor),
			winLable.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor,
												   constant: leadingTrailingAnchorWinLable),
			winLable.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor,
													constant: -leadingTrailingAnchorWinLable),
			winLable.heightAnchor.constraint(equalToConstant: winLableHeightAnchor),

			logoImageView.topAnchor.constraint(equalTo: self.winLable.bottomAnchor,
											   constant: logoImageTopAnchor),
			logoImageView.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
			logoImageView.heightAnchor.constraint(equalToConstant: logoImageViewHeightAnchor),
			logoImageView.widthAnchor.constraint(equalToConstant: logoImageViewWidthAnchor),

			doneButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor,
											   constant: leadingTrailingAnchorStackView),
			doneButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor,
												constant: -leadingTrailingAnchorStackView),
			doneButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor,
											constant: -doneButtonBottomAnchor),
			doneButton.heightAnchor.constraint(equalToConstant: stackViewHeightAnchor)
		])
	}

	@objc func handleDoneTouchUpInseide() {
		delegate?.done()
	}
}
