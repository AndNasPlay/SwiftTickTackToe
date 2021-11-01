//
//  GameViewControllerView.swift
//  SwiftTickTackToe
//
//  Created by Андрей Щекатунов on 11.10.2021.
//

import UIKit

class GameViewControllerView: UIView {

	private(set) lazy var leadingTrailingLableAnchor: CGFloat = 20.0

	private(set) lazy var topLableHeightAnchor: CGFloat = 20.0

	private(set) lazy var topLableAnchor: CGFloat = 20.0

	private(set) lazy var lableUIFontSize: CGFloat = 20.0

	private(set) lazy var stackViewbuttonSpacing: CGFloat = 5.0

	private(set) lazy var firstPlayerLable: UILabel = {
		let text = UILabel()
		text.translatesAutoresizingMaskIntoConstraints = false
		text.textColor = .boardLineColor
		text.textAlignment = .center
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
		text.textAlignment = .center
		text.textColor = .boardLineColor
		text.font = UIFont.boldSystemFont(ofSize: lableUIFontSize)
		text.text = "Computer"
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
		stackView.distribution = .fillEqually
		return stackView
	}()

	private(set) lazy var secondPlayerStackView: UIStackView = {
		var stackView = UIStackView()
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.axis = .horizontal
		stackView.alignment = .fill
		stackView.spacing = stackViewbuttonSpacing
		stackView.distribution = .fillEqually
		return stackView
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
		self.secondPlayerStackView.addArrangedSubview(secondPlayerMark)
		self.secondPlayerStackView.addArrangedSubview(secondPlayerLable)
		self.addSubview(winLable)
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

			secondPlayerStackView.leadingAnchor.constraint(equalTo: self.centerXAnchor, constant: leadingTrailingLableAnchor),
			secondPlayerStackView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor,
														constant: -leadingTrailingLableAnchor),
			secondPlayerStackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor,
												   constant: topLableAnchor),
			secondPlayerStackView.heightAnchor.constraint(equalToConstant: topLableHeightAnchor),

			winLable.centerXAnchor.constraint(equalTo: self.centerXAnchor),
			winLable.topAnchor.constraint(equalTo: self.firstPlayerStackView.bottomAnchor,
										  constant: topLableAnchor),
			winLable.heightAnchor.constraint(equalToConstant: topLableHeightAnchor)
		])
	}
}
