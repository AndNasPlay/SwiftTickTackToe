//
//  ComputerState.swift
//  SwiftTickTackToe
//
//  Created by Андрей Щекатунов on 16.10.2021.
//

import Foundation

public class ComputerState: GameState {

	public private(set) var isCompleted = false

	public let player: Player

	private(set) weak var viewController: GameViewController!

	init(player: Player, viewController: GameViewController) {
		self.player = player
		self.viewController = viewController
	}

	public func begin() {
		switch self.player {
		case .first:
			self.viewController.newView.firstPlayerStackView.isHidden = false
			self.viewController.newView.secondPlayerStackView.isHidden = true
		case .computer:
			self.viewController.newView.firstPlayerStackView.isHidden = true
			self.viewController.newView.secondPlayerStackView.isHidden = false
			computerMakeStep()
		default:
			return
		}
	}

	public func addMark(at position: GameboardPosition) {
		guard let gameboardView = self.viewController?.gameboardView,
			gameboardView.canPlaceMarkView(at: position),
			player == .first

		else { return }

		let markView: MarkView = XView()

		viewController.gameBoard.setPlayer(self.player, at: position)
		gameboardView.placeMarkView(markView, at: position)
		self.isCompleted = true
		nextStep()
	}

	private func computerMakeStep() {

		DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) { [weak self] in
			guard let self = self,
				  let viewController = self.viewController,
				  let position = ComputerPosition.shared.nextStep(
															gameboard: viewController.gameBoard,
															complexity: viewController.complexity)
			else { return }

			viewController.gameBoard.setPlayer(.computer, at: position)
			let markView: MarkView = OView()
			viewController.gameboardView.placeMarkView(markView, at: position)
			self.isCompleted = true
			self.nextStep()
		}
	}

	private func nextStep() {
		let nextStepState = ComputerState(player: player.next(gameType: viewController.gameType),
										  viewController: viewController)

		let state = ReviewGameState(viewController: viewController, nextState: nextStepState)
		viewController.goToNextState(state)
	}
}
