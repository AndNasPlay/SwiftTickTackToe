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

	var computerMovesArray: [GameboardPosition] = []

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

		var column: Int = Int.random(in: 0..<3)
		var row: Int = Int.random(in: 0..<3)
		var position = GameboardPosition(column: column, row: row)

		if GameboardState.shared.allGameboardPositions.count < 2 {

			while gameboard.contains(at: position) != nil {
				column = Int.random(in: 0..<3)
				row = Int.random(in: 0..<3)
				position = GameboardPosition(column: column, row: row)
			}
			return position
		}

		var counter = 1

		while counter <= GameboardState.shared.allGameboardPositions.count {
			if counter % 2 == 0 {
				computerMovesArray.append(GameboardState.shared.allGameboardPositions[counter])
			}
			counter += 1
		}

		var winPatternsFirstCounter = 0

		while  winPatternsFirstCounter < winPatterns.count {
			winPatternsFirstCounter += 1

			for newCounter in 0...2 {
				if computerMovesArray.contains(winPatterns[winPatternsFirstCounter][newCounter]) {

				}

			}
		}

		return nil
	}
}
