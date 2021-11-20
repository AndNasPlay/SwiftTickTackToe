//
//  FiveStepsPlayerState.swift
//  SwiftTickTackToe
//
//  Created by Андрей Щекатунов on 05.11.2021.
//

import Foundation

class FiveStepsPlayerState: GameState {

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
			gameViewController?.newView.secondPlayerLable.text = "2nd player"
		case .autoStepFirst:
			gameViewController?.newView.firstPlayerStackView.isHidden = false
			gameViewController?.newView.secondPlayerStackView.isHidden = true
			firstAutoMakeStep()
		case .autoStepSecond:
			gameViewController?.newView.firstPlayerStackView.isHidden = true
			gameViewController?.newView.secondPlayerStackView.isHidden = false
			gameViewController?.newView.secondPlayerLable.text = "2nd player"
			secondAutoMakeStep()
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

		self.isCompleted = true
		nextStep()
	}

	private func nextStep() {
		let nextStepState = FiveStepsPlayerState(player: player.next(gameType: gameViewController!.gameType),
												 gameViewController: gameViewController!)
		let state = FiveStepsReviewGameState(viewController: gameViewController!, nextState: nextStepState)
		gameViewController!.goToNextState(state)
	}

	private func firstAutoMakeStep() {
		DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) { [weak self] in
			guard let self = self,
				  let viewController = self.gameViewController,
				  let position = AutoStepPosition.shared.nextStep(gameboard: viewController.gameBoard)

			else { return }
			let markView = XView()
			viewController.gameBoard.setPlayer(.autoStepSecond, at: position)
			if viewController.gameBoard.contains(at: position) != nil {
				viewController.gameboardView.removeMarkView(at: position)
			}
			viewController.gameboardView.placeMarkView(markView, at: position)
			self.isCompleted = true
			self.nextStep()
		}
	}

	private func secondAutoMakeStep() {
		DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) { [weak self] in
			guard let self = self,
				  let viewController = self.gameViewController,
				  let position = AutoStepPosition.shared.nextStep(gameboard: viewController.gameBoard)

			else { return }
			let markView = OView()
			viewController.gameBoard.setPlayer(.autoStepFirst, at: position)
			if viewController.gameBoard.contains(at: position) != nil {
				viewController.gameboardView.removeMarkView(at: position)
			}
			viewController.gameboardView.placeMarkView(markView, at: position)
			self.isCompleted = true
			self.nextStep()
		}
	}
}
