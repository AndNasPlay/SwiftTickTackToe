//
//  FiveStepsPlayerState.swift
//  SwiftTickTackToe
//
//  Created by Андрей Щекатунов on 05.11.2021.
//

import Foundation

class FiveStepsPlayerState: GameState {

	var isCompleted: Bool = false

	let stepsCount: Int = 5

	var stepNumber: Int

	public let player: Player

	private weak var gameViewController: GameViewController?

	init( player: Player, gameViewController: GameViewController, stepNumber: Int) {
		self.player = player
		self.gameViewController = gameViewController
		self.stepNumber = stepNumber
	}

	func begin() {
		switch player {
		case .first:
			gameViewController?.newView.firstPlayerStackView.isHidden = false
			gameViewController?.newView.secondPlayerStackView.isHidden = true
		case .second:
			gameViewController?.newView.firstPlayerStackView.isHidden = true
			gameViewController?.newView.secondPlayerStackView.isHidden = false
			gameViewController?.newView.secondPlayerLable.text = "2nd player"
		default: break
		}
	}

	func addMark(at position: GameboardPosition) {

		guard let gameBoardView = gameViewController?.gameboardView, gameBoardView.canPlaceMarkView(at: position)
		else { return }

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

		let command = MarkFromCommand(player: player, position: position, viewController: gameViewController!)
		Invoker.shared.addCommand(player: player, command: command)

		if stepNumber < stepsCount {
			stepNumber += 1
		}

		if stepNumber == stepsCount && player == .second {
			gameViewController?.gameboardView.clear()
			gameViewController?.gameBoard.clear()
			Invoker.shared.executeGame()
			DispatchQueue.main.asyncAfter(deadline: .now() + 5.5) { [self] in
				nextStep(stepNumber: 0)
				self.isCompleted = true
			}
		} else if stepNumber == stepsCount {
			gameViewController?.gameboardView.clear()
			gameViewController?.gameBoard.clear()
			nextStep(stepNumber: 0)
			self.isCompleted = true
			return
		}
	}

	private func nextStep(stepNumber: Int) {
		let nextStepState = FiveStepsPlayerState(player: player.next(gameType: gameViewController!.gameType),
												 gameViewController: gameViewController!, stepNumber: stepNumber)
		let state = FiveStepsReviewGameState(viewController: gameViewController!, nextState: nextStepState)
		gameViewController!.goToNextState(state)
	}
}
