//
//  ComputerPosition.swift
//  SwiftTickTackToe
//
//  Created by Андрей Щекатунов on 16.10.2021.
//

import Foundation

public class ComputerPosition {

	static public let shared = ComputerPosition()

	private init() { }

	var position = GameboardPosition(column: 0, row: 0)

	var computerMovesAlgorithm = ComputerMovesAlgorithm()

	var allBoardMovesArray: [GameboardPosition] = []

	var winPatterns: [[GameboardPosition]] = [
		[
			GameboardPosition(column: 0, row: 0),
			GameboardPosition(column: 1, row: 1),
			GameboardPosition(column: 2, row: 2)
		],
		[
			GameboardPosition(column: 0, row: 0),
			GameboardPosition(column: 1, row: 0),
			GameboardPosition(column: 2, row: 0)
		],
		[
			GameboardPosition(column: 0, row: 1),
			GameboardPosition(column: 1, row: 1),
			GameboardPosition(column: 2, row: 1)
		],
		[
			GameboardPosition(column: 0, row: 2),
			GameboardPosition(column: 1, row: 2),
			GameboardPosition(column: 2, row: 2)
		],
		[
			GameboardPosition(column: 0, row: 2),
			GameboardPosition(column: 1, row: 1),
			GameboardPosition(column: 2, row: 0)
		],
		[
			GameboardPosition(column: 0, row: 0),
			GameboardPosition(column: 0, row: 1),
			GameboardPosition(column: 0, row: 2)
		],
		[
			GameboardPosition(column: 1, row: 0),
			GameboardPosition(column: 1, row: 1),
			GameboardPosition(column: 1, row: 2)
		],
		[
			GameboardPosition(column: 2, row: 0),
			GameboardPosition(column: 2, row: 1),
			GameboardPosition(column: 2, row: 2)
		]
	]

	func findPositionForWin(gameboard: Gameboard, allMoveAiArray: [GameboardPosition]) -> GameboardPosition {
		var winPatternsForAI: [GameboardPosition] = []
		var positionForWin = GameboardPosition(column: 0, row: 0)
		for winCounter in 0...7 {
			winPatternsForAI = winPatterns[winCounter]
			for counter in 0...allMoveAiArray.count - 1 {
				if winPatterns[winCounter].contains(allMoveAiArray[counter]) {
					if let idx = winPatternsForAI.firstIndex(where: { $0 == allMoveAiArray[counter] }) {
						winPatternsForAI.remove(at: idx)
					}
				}
			}
			if !winPatternsForAI.isEmpty {
				if winPatternsForAI.count == 1 && !allBoardMovesArray.contains(winPatternsForAI.first!) {
					positionForWin = winPatternsForAI[0]
					if gameboard.contains(at: position) == nil {
						return positionForWin
					}
				}
			}
		}
		return positionForWin
	}

	func findPositionForCancel(gameboard: Gameboard, allMoveHumanArray: [GameboardPosition]) -> GameboardPosition {
		var winPatternsForHuman: [GameboardPosition] = []
		var positionForWin = GameboardPosition(column: 0, row: 0)
		for winCounter in 0...7 {
			winPatternsForHuman = winPatterns[winCounter]
			for counter in 0...allMoveHumanArray.count - 1 {
				if winPatterns[winCounter].contains(allMoveHumanArray[counter]) {
					if let idx = winPatternsForHuman.firstIndex(where: { $0 == allMoveHumanArray[counter] }) {
						winPatternsForHuman.remove(at: idx)
					}
				}
			}
			if !winPatternsForHuman.isEmpty {
				if winPatternsForHuman.count == 1 && !allBoardMovesArray.contains(winPatternsForHuman.first!) {
					positionForWin = winPatternsForHuman[0]
					if gameboard.contains(at: position) == nil {
						break
					}
				}
			}
		}
		return positionForWin
	}

	func findRandomStep(gameboard: Gameboard) -> GameboardPosition {

		var column: Int = Int.random(in: 0..<GameboardSize.columns)
		var row: Int = Int.random(in: 0..<GameboardSize.rows)
		var randomPosition = GameboardPosition(column: column, row: row)

		while gameboard.contains(at: randomPosition) != nil {
			column = Int.random(in: 0..<GameboardSize.columns)
			row = Int.random(in: 0..<GameboardSize.rows)
			randomPosition = GameboardPosition(column: column, row: row)
		}
		return randomPosition
	}

	func nextStep(gameboard: Gameboard, complexity: SinglePlayerGameComplexity) -> GameboardPosition? {

		if GameboardState.shared.gamesPlayed % 3 == 0 && complexity == .hard && GameboardState.shared.allGameboardPositions[0] == GameboardPosition(column: 2, row: 0) {

			allBoardMovesArray = GameboardState.shared.allGameboardPositions

			if allBoardMovesArray.count < 3 {
				return findRandomStep(gameboard: gameboard)
			} else {
				var allMoveAiArray: [GameboardPosition] = []
				var allMoveHumanArray: [GameboardPosition] = []
				for counter in 0...allBoardMovesArray.count - 1 {
					if counter == 0 || counter % 2 == 0 {
						allMoveHumanArray.append(allBoardMovesArray[counter])
					} else {
						allMoveAiArray.append(allBoardMovesArray[counter])
					}
				}
				let positionForWin = findPositionForWin(gameboard: gameboard, allMoveAiArray: allMoveAiArray)
				let positionForCancel = findPositionForCancel(gameboard: gameboard, allMoveHumanArray: allMoveHumanArray)

				if  positionForWin != GameboardPosition(column: 0, row: 0) {
					position = positionForWin
					return position
				} else if  positionForCancel != GameboardPosition(column: 0, row: 0) {
					position = positionForCancel
					return position
				} else {
					return findRandomStep(gameboard: gameboard)
				}
			}
		} else if complexity == .hard {
			position = computerMovesAlgorithm.prepareForBoard(
				gameboardPositions: computerMovesAlgorithm.minimax(newBoard: computerMovesAlgorithm.prepareForMinimax(
																	gameboardPositions: GameboardState.shared.allGameboardPositions),
																   player: computerMovesAlgorithm.computer))

			if gameboard.contains(at: position) == nil {
				return position
			} else {
				return findRandomStep(gameboard: gameboard)
			}
		} else {

			allBoardMovesArray = GameboardState.shared.allGameboardPositions

			if allBoardMovesArray.count < 3 {
				return findRandomStep(gameboard: gameboard)
			} else {
				var allMoveAiArray: [GameboardPosition] = []
				var allMoveHumanArray: [GameboardPosition] = []
				for counter in 0...allBoardMovesArray.count - 1 {
					if counter == 0 || counter % 2 == 0 {
						allMoveHumanArray.append(allBoardMovesArray[counter])
					} else {
						allMoveAiArray.append(allBoardMovesArray[counter])
					}
				}
				let positionForWin = findPositionForWin(gameboard: gameboard, allMoveAiArray: allMoveAiArray)
				let positionForCancel = findPositionForCancel(gameboard: gameboard, allMoveHumanArray: allMoveHumanArray)

				if  positionForWin != GameboardPosition(column: 0, row: 0) {
					position = positionForWin
					return position
				} else if  positionForCancel != GameboardPosition(column: 0, row: 0) {
					position = positionForCancel
					return position
				} else {
					return findRandomStep(gameboard: gameboard)
				}
			}
		}
	}
}
