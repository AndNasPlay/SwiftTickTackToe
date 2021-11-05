//
//  GameViewController.swift
//  SwiftTickTackToe
//
//  Created by Андрей Щекатунов on 11.10.2021.
//

import UIKit

public class GameViewController: UIViewController, CongratulatoryDelegate {

	var newView = GameViewControllerView()

	public let gameBoard = Gameboard()

	public var gameboardView = GameboardView()

	private(set) lazy var congratulatoryViewController = CongratulatoryViewController()

	private(set) var gameType: GameType = .multiplayer

	private(set) var complexity: SinglePlayerGameComplexity

	private(set) lazy var referee = Referee(gameboard: self.gameBoard)

	private(set) lazy var leadingTrailingGameBoardAnchor: CGFloat = 30.0

	private(set) lazy var navBarButtonWidthHeightAnchor: CGFloat = 35.0

	private(set) lazy var topAnchorGameBoard: CGFloat = 80.0

	private(set) lazy var backButtonForNavBar: UIButton = {
		let button = UIButton(type: .custom)
		button.setImage(UIImage(named: "backImg"), for: .normal)
		button.addTarget(self, action: #selector(handleBackTouchUpInseide), for: .touchUpInside)
		return button
	}()

	private(set) lazy var refreshButtonForNavBar: UIButton = {
		let button = UIButton(type: .custom)
		button.setImage(UIImage(named: "restart"), for: .normal)
		button.addTarget(self, action: #selector(handleRestartTouchUpInseide), for: .touchUpInside)
		return button
	}()

	private(set) lazy var leftBarButton = UIBarButtonItem(customView: backButtonForNavBar)
	private(set) lazy var rightBarButton = UIBarButtonItem(customView: refreshButtonForNavBar)

	private var currentState: GameState! {
		didSet {
			currentState.begin()
		}
	}

	init(gameMode: GameType, complexity: SinglePlayerGameComplexity) {
		self.complexity = complexity
		self.gameType = gameMode
		super.init(nibName: nil, bundle: nil)
	}

	required convenience init?(coder: NSCoder) {
		self.init(gameMode: .multiplayer, complexity: .easy)
	}

	public override func viewDidLoad() {
		super.viewDidLoad()
		self.congratulatoryViewController.delegate = self
		view = newView
		view.addSubview(gameboardView)
		navigationController?.navigationBar.isHidden = false
		navigationController?.navigationBar.barTintColor = .viewBackgroundColor

		navigationItem.rightBarButtonItem = rightBarButton
		navigationItem.leftBarButtonItem = leftBarButton

		constraintsInit()
		setFirstState()

		gameboardView.onSelectPosition = { [weak self] position in
			guard let self = self else { return }
			self.currentState.addMark(at: position)
		}
	}

	private func setFirstState() {
		gameBoard.clear()
		gameboardView.clear()
		GameboardState.shared.clear()
		self.currentState = GameTypeState().checkState(gameType: self.gameType, viewController: self)
	}

	func goToNextState(_ state: GameState) {
		self.currentState = state
	}

	func congratulationPopUp() {
		congratulatoryViewController.modalPresentationStyle = .overCurrentContext
		congratulatoryViewController.modalTransitionStyle = .crossDissolve
		present(congratulatoryViewController, animated: true, completion: nil)
	}

	func constraintsInit() {
		leftBarButton.customView?.widthAnchor.constraint(equalToConstant: navBarButtonWidthHeightAnchor).isActive = true
		leftBarButton.customView?.heightAnchor.constraint(equalToConstant: navBarButtonWidthHeightAnchor).isActive = true

		rightBarButton.customView?.widthAnchor.constraint(equalToConstant: navBarButtonWidthHeightAnchor).isActive = true
		rightBarButton.customView?.heightAnchor.constraint(equalToConstant: navBarButtonWidthHeightAnchor).isActive = true

		gameboardView.leadingAnchor.constraint(equalTo: self.newView.leadingAnchor,
											   constant: leadingTrailingGameBoardAnchor).isActive = true
		gameboardView.trailingAnchor.constraint(equalTo: self.newView.trailingAnchor,
												constant: -leadingTrailingGameBoardAnchor).isActive = true
		gameboardView.centerYAnchor.constraint(equalTo: self.newView.centerYAnchor).isActive = true
		gameboardView.topAnchor.constraint(equalTo: self.newView.firstPlayerLable.bottomAnchor,
										   constant: topAnchorGameBoard).isActive = true
	}

	func restart() {
		setFirstState()
	}

	@objc func handleRestartTouchUpInseide() {
		setFirstState()
	}

	@objc func handleBackTouchUpInseide() {
		self.navigationController?.popViewController(animated: true)
	}
}
