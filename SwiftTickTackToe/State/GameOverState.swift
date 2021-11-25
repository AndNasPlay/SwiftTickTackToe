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

		if let winner = winner {
			gameViewController?.congratulationPopUp()
			gameViewController?.congratulatoryViewController.newView.winLable.text = getWinnerName(from: winner) + " won"
		} else {
			gameViewController?.congratulatoryViewController.newView.winLable.text = "No winner"
			gameViewController?.congratulationPopUp()
		}
		gameViewController?.newView.firstPlayerStackView.isHidden = true
		gameViewController?.newView.secondPlayerStackView.isHidden = true
	}

	func addMark(at position: GameboardPosition) { }

	func getWinnerName(from: Player) -> String {
		switch winner {
		case .first:
			return "You"
		case .second:
			return "2nd player"
		case .computer:
			return "Computer"
		case .none:
			return "There is no winner"
		}
	}
}
