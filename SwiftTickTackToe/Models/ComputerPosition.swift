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

	func nextStep(gameboard: Gameboard) -> GameboardPosition? {

		if GameboardState.shared.allGameboardPositions.count < 2 {
			var column: Int = Int.random(in: 0..<3)
			var row: Int = Int.random(in: 0..<3)
			var position = GameboardPosition(column: column, row: row)

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

		return nil
	}
}
