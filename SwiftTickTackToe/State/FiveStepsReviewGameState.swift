//
//  FiveStepsReviewGameState.swift
//  SwiftTickTackToe
//
//  Created by Андрей Щекатунов on 05.11.2021.
//

import Foundation

public class FiveStepsReviewGameState: GameState {

	public var isCompleted: Bool = false
	private var nextState: GameState
	private weak var viewController: GameViewController?

	init(viewController: GameViewController, nextState: GameState) {
		self.nextState = nextState
		self.viewController = viewController
	}

	public func begin() {
		guard let viewController = self.viewController else {
			return
		}

		if GameboardState.shared.allGameboardPositions.count == 5 || GameboardState.shared.allGameboardPositions.count == 10 {
			viewController.gameBoard.clear()
			viewController.gameboardView.clear()
		}

		if GameboardState.shared.allGameboardPositions.count > 10 {
			if let winner = viewController.referee.determineWinner() {
				viewController.goToNextState(GameOverState(winner: winner, gameViewController: viewController))
				return
			}
			if viewController.gameBoard.noMoreStepsForFiveSteps() {
				viewController.goToNextState(GameOverState(winner: nil, gameViewController: viewController))
				return
			}
		}
		viewController.goToNextState(nextState)
	}

	public func addMark(at position: GameboardPosition) {}
}
