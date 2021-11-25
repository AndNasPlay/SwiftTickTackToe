//
//  GameViewControllerView.swift
//  SwiftTickTackToe
//
//  Created by Андрей Щекатунов on 11.10.2021.
//

import UIKit

class GameViewControllerView: UIView {

	private(set) lazy var leadingTrailingLableAnchor: CGFloat = 20.0

	private(set) lazy var topLableHeightAnchor: CGFloat = 23.0

	private(set) lazy var lableWidthAnchor: CGFloat = 23.0

	private(set) lazy var topLableAnchor: CGFloat = 20.0

	private(set) lazy var lableUIFontSize: CGFloat = 20.0

	private(set) lazy var stackViewbuttonSpacing: CGFloat = 10.0

	private(set) lazy var firstPlayerLable: UILabel = {
		let text = UILabel()
		text.translatesAutoresizingMaskIntoConstraints = false
		text.textColor = .playerNameColor
		text.textAlignment = .left
		text.font = UIFont.boldSystemFont(ofSize: lableUIFontSize)
		text.text = "YOU"
		return text
	}()

	private(set) lazy var firstPlayerMark: UIImageView = {
		let image = UIImageView()
		image.translatesAutoresizingMaskIntoConstraints = false
		image.image = UIImage(named: "XmarkView")
		return image
	}()

	private(set) lazy var secondPlayerLable: UILabel = {
		let text = UILabel()
		text.translatesAutoresizingMaskIntoConstraints = false
		text.textAlignment = .right
		text.textColor = .playerNameColor
		text.font = UIFont.boldSystemFont(ofSize: lableUIFontSize)
		text.text = "RIVAL"
		return text
	}()

	private(set) lazy var secondPlayerMark: UIImageView = {
		let image = UIImageView()
		image.translatesAutoresizingMaskIntoConstraints = false
		image.image = UIImage(named: "OmakrView")
		return image
	}()

	private(set) lazy var firstPlayerStackView: UIStackView = {
		var stackView = UIStackView()
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.axis = .horizontal
		stackView.alignment = .fill
		stackView.spacing = stackViewbuttonSpacing

		return stackView
	}()

	private(set) lazy var secondPlayerStackView: UIStackView = {
		var stackView = UIStackView()
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.axis = .horizontal
		stackView.alignment = .fill
		stackView.spacing = stackViewbuttonSpacing
		return stackView
	}()

	override init(frame: CGRect) {
		super.init(frame: frame)
		self.backgroundColor = .viewBackgroundColor
		createSubviews()
		constraintsInit()
	}

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		self.backgroundColor = .viewBackgroundColor
		createSubviews()
		constraintsInit()
	}

	func createSubviews() {
		self.addSubview(firstPlayerStackView)
		self.addSubview(secondPlayerStackView)
		self.firstPlayerStackView.addArrangedSubview(firstPlayerMark)
		self.firstPlayerStackView.addArrangedSubview(firstPlayerLable)
		self.secondPlayerStackView.addArrangedSubview(secondPlayerLable)
		self.secondPlayerStackView.addArrangedSubview(secondPlayerMark)
	}

	func constraintsInit() {
		NSLayoutConstraint.activate([

			firstPlayerStackView.leadingAnchor.constraint(
				equalTo: self.safeAreaLayoutGuide.leadingAnchor,
				constant: leadingTrailingLableAnchor),
			firstPlayerStackView.trailingAnchor.constraint(equalTo: self.centerXAnchor, constant: -leadingTrailingLableAnchor ),
			firstPlayerStackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor,
												  constant: topLableAnchor),
			firstPlayerStackView.heightAnchor.constraint(equalToConstant: topLableHeightAnchor),

			firstPlayerMark.widthAnchor.constraint(equalToConstant: lableWidthAnchor),

			secondPlayerStackView.leadingAnchor.constraint(equalTo: self.centerXAnchor, constant: leadingTrailingLableAnchor),
			secondPlayerStackView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor,
														constant: -leadingTrailingLableAnchor),
			secondPlayerStackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor,
												   constant: topLableAnchor),
			secondPlayerStackView.heightAnchor.constraint(equalToConstant: topLableHeightAnchor),

			secondPlayerMark.widthAnchor.constraint(equalToConstant: lableWidthAnchor)
		])
	}
}
