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

	private(set) lazy var topAnchorGameBoard: CGFloat = 80.0

	private(set) lazy var refreshButton: UIBarButtonItem = UIBarButtonItem(
		image: UIImage(named: "restart"),
		style: .done,
		target: self,
		action: #selector(handleRestartTouchUpInseide))

	private(set) lazy var backButton: UIBarButtonItem = UIBarButtonItem(
		image: UIImage(named: "backImg"),
		style: .done,
		target: self,
		action: #selector(handleBackTouchUpInseide))

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
		navigationItem.rightBarButtonItem = refreshButton
		navigationItem.rightBarButtonItem!.tintColor = .brown

		navigationItem.leftBarButtonItem = backButton
		navigationItem.leftBarButtonItem!.tintColor = .brown

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
		NSLayoutConstraint.activate([

			gameboardView.leadingAnchor.constraint(equalTo: self.newView.leadingAnchor,
												   constant: leadingTrailingGameBoardAnchor),
			gameboardView.trailingAnchor.constraint(equalTo: self.newView.trailingAnchor,
													constant: -leadingTrailingGameBoardAnchor),
			gameboardView.centerYAnchor.constraint(equalTo: self.newView.centerYAnchor),
			gameboardView.topAnchor.constraint(equalTo: self.newView.firstPlayerLable.bottomAnchor, constant: topAnchorGameBoard)
		])
	}

	func restart() {
		setFirstState()
	}

	@objc func handleRestartTouchUpInseide() {
		gameboardView.clear()
		gameBoard.clear()
		GameboardState.shared.clear()
		setFirstState()
	}

	@objc func handleBackTouchUpInseide() {
		self.navigationController?.popViewController(animated: true)
	}
}
