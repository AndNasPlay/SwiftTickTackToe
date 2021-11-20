//
//  GameboardState.swift
//  SwiftTickTackToe
//
//  Created by Андрей Щекатунов on 25.10.2021.
//

import Foundation

class GameboardState {

	static public let shared = GameboardState()

	private init() { }

	var allGameboardPositions: [GameboardPosition] = []

	func clear() {
		allGameboardPositions.removeAll()
		AutoStepPosition.shared.moveCounter = -1
	}

	func addMove(gameboardPosition: GameboardPosition) {
		allGameboardPositions.append(gameboardPosition)
	}

	func getBoardMarks() -> [GameboardPosition] {
		return allGameboardPositions
	}
}
