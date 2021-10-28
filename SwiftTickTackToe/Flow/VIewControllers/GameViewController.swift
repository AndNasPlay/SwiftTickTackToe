//
//  GameViewController.swift
//  SwiftTickTackToe
//
//  Created by Андрей Щекатунов on 11.10.2021.
//

import UIKit

public class GameViewController: UIViewController {

	var newView = GameViewControllerView()

	public let gameBoard = Gameboard()

	public var gameboardView = GameboardView()

	private(set) var gameType: GameType = .multiplayer

	private(set) lazy var referee = Referee(gameboard: self.gameBoard)

	private(set) lazy var leadingTrailingGameBoardAnchor: CGFloat = 20.0

	private(set) lazy var topAnchorGameBoard: CGFloat = 50.0

	private var currentState: GameState! {
		didSet {
			currentState.begin()
		}
	}

	init(gameMode: GameType) {
		self.gameType = gameMode
		super.init(nibName: nil, bundle: nil)
	}

	required convenience init?(coder: NSCoder) {
		self.init(gameMode: .multiplayer)
	}

	public override func viewDidLoad() {
		super.viewDidLoad()
		view = newView
		view.addSubview(gameboardView)
		navigationController?.navigationBar.isHidden = false
		navigationController?.navigationBar.barTintColor = .lightGray
		navigationItem.rightBarButtonItem = UIBarButtonItem(
			barButtonSystemItem: .refresh,
			target: self,
			action: #selector(handleRestartTouchUpInseide)
		)
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

	func constraintsInit() {
		NSLayoutConstraint.activate([

			gameboardView.leadingAnchor.constraint(equalTo: self.newView.leadingAnchor,
												   constant: leadingTrailingGameBoardAnchor),
			gameboardView.trailingAnchor.constraint(equalTo: self.newView.trailingAnchor,
													constant: -leadingTrailingGameBoardAnchor),
			gameboardView.centerYAnchor.constraint(equalTo: self.newView.centerYAnchor),
			gameboardView.topAnchor.constraint(equalTo: self.newView.winLable.bottomAnchor,
											   constant: topAnchorGameBoard)
		])
	}

	@objc func handleRestartTouchUpInseide() {
		gameboardView.clear()
		gameBoard.clear()
		GameboardState.shared.clear()
		setFirstState()
	}
}
