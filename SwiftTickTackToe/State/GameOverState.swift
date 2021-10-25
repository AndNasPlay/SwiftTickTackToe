//
//  GameOverState.swift
//  SwiftTickTackToe
//
//  Created by Андрей Щекатунов on 12.10.2021.
//

import Foundation

class GameOverState: GameState {

	var isCompleted: Bool = false

	public let winner: Player?

	private weak var gameViewController: GameViewController?

	init(winner: Player?, gameViewController: GameViewController) {
		self.winner = winner
		self.gameViewController = gameViewController
	}

	func begin() {

		gameViewController?.newView.winLable.isHidden = false

		if let winner = winner {
			gameViewController?.newView.winLable.text = getWinnerName(from: winner) + " won"
		} else {
			gameViewController?.newView.winLable.text = "No winner"
		}
		gameViewController?.newView.firstPlayerLable.isHidden = true
		gameViewController?.newView.secondPlayerLable.isHidden = true
	}

	func addMark(at position: GameboardPosition) { }

	func getWinnerName(from: Player) -> String {
		switch winner {
		case .first:
			return "1st player"
		case .second:
			return "2nd player"
		case .computer:
			return "2nd player"
		case .none:
			return "There is no winner"
		}
	}
}
