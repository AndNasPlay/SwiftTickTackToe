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

	var gamesPlayed: Int = 0

	func clear() {
		allGameboardPositions.removeAll()
	}

	func addGame() {
		gamesPlayed += 1
	}

	func updateGameCounter() {
		gamesPlayed = 1
	}

	func addMove(gameboardPosition: GameboardPosition) {
		allGameboardPositions.append(gameboardPosition)
	}

	func getBoardMarks() -> [GameboardPosition] {
		return allGameboardPositions
	}
}
