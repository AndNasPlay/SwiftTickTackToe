//
//  GameVsComputerState.swift
//  SwiftTickTackToe
//
//  Created by Андрей Щекатунов on 14.10.2021.
//

import Foundation

class GameVsComputerState: GameState {
	var isMoveCompleted: Bool = false

	public let player: Player
	private weak var gameViewController: GameViewController?
	private weak var gameBoard: Gameboard?
	private weak var gameBoardView: GameboardView?

	public let markViewPrototype: MarkView

	init(
		player: Player,
		gameViewController: GameViewController,
		gameBoard: Gameboard,
		gameBoardView: GameboardView,
		markViewPrototype: MarkView) {

		self.player = player
		self.gameViewController = gameViewController
		self.gameBoard = gameBoard
		self.gameBoardView = gameBoardView
		self.markViewPrototype = markViewPrototype
	}

	func begin() {
		switch player {
		case .first:
			gameViewController?.newView.firstPlayerLable.isHidden = false
			gameViewController?.newView.secondPlayerLable.isHidden = true
		case .second:
			gameViewController?.newView.firstPlayerLable.isHidden = true
			gameViewController?.newView.secondPlayerLable.isHidden = false
		}
		gameViewController?.newView.winLable.isHidden = true
	}

	func addMark(at position: GameboardPosition) {

		guard let gameBoardView = gameBoardView, gameBoardView.canPlaceMarkView(at: position) else {
			return
		}

		gameBoard?.setPlayer(player, at: position)
		gameBoardView.placeMarkView(markViewPrototype.copy(), at: position)
		isMoveCompleted = true
	}
}
