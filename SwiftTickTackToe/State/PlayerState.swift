//
//  PlayerState.swift
//  SwiftTickTackToe
//
//  Created by Андрей Щекатунов on 12.10.2021.
//

import Foundation

class PlayerState: GameState {

	var isCompleted: Bool = false

	public let player: Player
	private weak var gameViewController: GameViewController?

	init( player: Player, gameViewController: GameViewController) {
		self.player = player
		self.gameViewController = gameViewController
	}

	func begin() {
		switch player {
		case .first:
			gameViewController?.newView.firstPlayerStackView.isHidden = false
			gameViewController?.newView.secondPlayerStackView.isHidden = true
		case .second:
			gameViewController?.newView.firstPlayerStackView.isHidden = true
			gameViewController?.newView.secondPlayerStackView.isHidden = false
			gameViewController?.newView.secondPlayerLable.text = "RIVAL"
		default: break
		}
	}

	func addMark(at position: GameboardPosition) {

		guard let gameBoardView = gameViewController?.gameboardView, gameBoardView.canPlaceMarkView(at: position)
		else {
			return
		}

		let markView: MarkView
		switch self.player {
		case .first:
			markView = XView()
		case .second:
			markView = OView()
		default:
			return
		}

		gameViewController?.gameBoard.setPlayer(self.player, at: position)
		gameViewController?.gameboardView.placeMarkView(markView, at: position)

		self.isCompleted = true
		nextStep()
	}

	private func nextStep() {
		let nextStepState = PlayerState(player: player.next(gameType: gameViewController!.gameType),
										gameViewController: gameViewController!)
		let state = ReviewGameState(viewController: gameViewController!, nextState: nextStepState)
		gameViewController!.goToNextState(state)
	}
}
