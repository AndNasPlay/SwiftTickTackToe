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

	var winPatternsFirstCounter = 0
	var winPatternsSecondCounter = 0

	var allMoveAiArray: [GameboardPosition] = []
	var allMoveHumanArray: [GameboardPosition] = []
	var allBoardMovesArray: [GameboardPosition] = []

	var winPatternsForAI: [[GameboardPosition]] = []
	var winPatternsForHuman: [[GameboardPosition]] = []

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

	func nextStep(gameboard: Gameboard) -> GameboardPosition? {

		//		var column: Int = Int.random(in: 0..<3)
		//		var row: Int = Int.random(in: 0..<3)
		//		var position = GameboardPosition(column: column, row: row)

		allBoardMovesArray = GameboardState.shared.allGameboardPositions

		winPatternsForAI = winPatterns
		winPatternsForHuman = winPatterns

		while winPatternsFirstCounter < allBoardMovesArray.count {

			if winPatternsFirstCounter == 0 || winPatternsFirstCounter % 2 != 0 {
				allMoveHumanArray.append(allBoardMovesArray[winPatternsFirstCounter])
			} else {
				allMoveAiArray.append(allBoardMovesArray[winPatternsFirstCounter])
			}
			winPatternsFirstCounter += 1
		}

		if allMoveHumanArray.count >= 2 {

			var newConunter = 0
			while newConunter <  winPatternsForHuman.count {
				for anotherCounter in 0...allMoveHumanArray.count - 1 {
					if newConunter < winPatternsForHuman.count && !winPatternsForHuman[newConunter].isEmpty {
						if winPatternsForHuman[newConunter].contains(allMoveHumanArray[anotherCounter]) {
							winPatternsForHuman.remove(at: newConunter)
						}
						newConunter += 1
					}
				}
			}

			var counter = 0
			for check in 0...winPatternsForHuman.count - 1 {
				position = winPatternsForHuman[check][counter]
				while gameboard.contains(at: position) != nil {
					position = winPatternsForHuman[check][counter]
					counter += 1
					if counter == 3 {
						counter = 0
						break
					}
				}
				counter = 0
				return position
			}
			return position

		} else {
			var newConunter = 0
			while newConunter <  winPatternsForAI.count {
				for anotherCounter in 0...allMoveHumanArray.count - 1 {
					if newConunter < winPatternsForAI.count && !winPatternsForAI[newConunter].isEmpty {
							if winPatternsForAI[newConunter].contains(allMoveHumanArray[anotherCounter]) {
								winPatternsForAI.remove(at: newConunter)
							}
							newConunter += 1
						}
				}
			}

			var counter = 0
			position = winPatternsForAI.first![counter]

			while gameboard.contains(at: position) != nil {
				position = winPatternsForAI.first![counter]
				counter += 1
			}
			counter = 0
			return position
		}
	}
}
