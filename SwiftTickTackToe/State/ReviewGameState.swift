//
//  ReviewGameState.swift
//  SwiftTickTackToe
//
//  Created by Андрей Щекатунов on 25.10.2021.
//

import Foundation

public class ReviewGameState: GameState {

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

		if let winner = viewController.referee.determineWinner() {
			if viewController.complexity == .hard && viewController.gameType == .singlePlayer {
				GameboardState.shared.addGame()
			}
			viewController.goToNextState(GameOverState(winner: winner, gameViewController: viewController))
			return
		}
		if viewController.gameBoard.noMoreSteps() {
			if viewController.complexity == .hard && viewController.gameType == .singlePlayer {
				GameboardState.shared.addGame()
			}
			viewController.goToNextState(GameOverState(winner: nil, gameViewController: viewController))
			return
		}
		viewController.goToNextState(nextState)
	}

	public func addMark(at position: GameboardPosition) {}
}
