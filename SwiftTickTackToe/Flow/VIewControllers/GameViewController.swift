//
//  GameViewController.swift
//  SwiftTickTackToe
//
//  Created by Андрей Щекатунов on 11.10.2021.
//

import UIKit

class GameViewController: UIViewController, GameViewControllerViewDelegate {

	public var newView = GameViewControllerView()

	private let gameBoard = Gameboard()

	private var gameboardView = GameboardView()

	private let gameMode: GameMode

	private lazy var referee = Referee(gameboard: gameBoard)

	private var currentState: GameState! {
		didSet {
			currentState.begin()
		}
	}

	private var counter: Int = 0

	init(gameMode: GameMode) {
		self.gameMode = gameMode
		super.init(nibName: nil, bundle: nil)
	}

	// swiftlint:disable unavailable_function
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	// swiftlint:enable unavailable_function

	override func viewDidLoad() {
		super.viewDidLoad()
		view = newView
		newView.delegate = self
		view.addSubview(gameboardView)
		navigationController?.navigationBar.isHidden = false
		navigationController?.navigationBar.barTintColor = .viewBackgroundColor
		tabBarController?.tabBar.barTintColor = UIColor.brown
		navigationItem.rightBarButtonItem = UIBarButtonItem(
			barButtonSystemItem: .refresh,
			target: self,
			action: #selector(handleRestartTouchUpInseide)
	 )
		constraintsInit()
		setFirstState()

		gameboardView.onSelectPosition = { [weak self] position in
			guard let self = self else { return }
			self.counter += 1
			self.currentState.addMark(at: position)
			if self.currentState.isMoveCompleted {
				self.setNextState()
			}
		}
	}

	private func setFirstState() {
		let player = Player.first
		currentState = PlayerState(player: player, gameViewController: self,
								   gameBoard: gameBoard, gameBoardView: gameboardView,
								   markViewPrototype: player.markViewPrototype)
	}

	private func setNextState() {
		if let winner = referee.determineWinner() {
			currentState = GameOverState(winner: winner, gameViewController: self)
			return
		}

		if counter >= 9 {
			currentState = GameOverState(winner: nil, gameViewController: self)
			return
		}

		if gameMode == .multiplayer {
			if let playerInputState = currentState as? PlayerState {
				let player = playerInputState.player.next
				currentState = PlayerState(player: playerInputState.player.next,
										   gameViewController: self,
										   gameBoard: gameBoard,
										   gameBoardView: gameboardView,
										   markViewPrototype: player.markViewPrototype)
			}
		} else if gameMode == .singlePlayer {

		}
	}

	func constraintsInit() {
		NSLayoutConstraint.activate([

			gameboardView.leadingAnchor.constraint(equalTo: self.newView.leadingAnchor, constant: 20.0),
			gameboardView.trailingAnchor.constraint(equalTo: self.newView.trailingAnchor, constant: -20.0),
			gameboardView.centerYAnchor.constraint(equalTo: self.newView.centerYAnchor),
			gameboardView.topAnchor.constraint(equalTo: self.newView.winLable.bottomAnchor, constant: 50.0)
		])
	}

	@objc func handleRestartTouchUpInseide() {
		gameboardView.clear()
		gameBoard.clear()
		setFirstState()
		counter = 0
	}

	func restartGame() {

	}
}
