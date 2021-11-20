//
//  AutoStepPosition.swift
//  SwiftTickTackToe
//
//  Created by Андрей Щекатунов on 18.11.2021.
//

import Foundation

public class AutoStepPosition {

	static public let shared = AutoStepPosition()

	private init() { }

	var position = GameboardPosition(column: 0, row: 0)

	var allBoardMovesArray: [GameboardPosition] = []

	var firstPlayerArray: [GameboardPosition] = []

	var secondPlayerArray: [GameboardPosition] = []

	var moveCounter: Int = -1

	func pushArray() {
		allBoardMovesArray = GameboardState.shared.allGameboardPositions

		for counter in 0...4 {
			firstPlayerArray.append(allBoardMovesArray[counter])
		}

		for counter in 5...9 {
			secondPlayerArray.append(allBoardMovesArray[counter])
		}
	}

	func nextStep(gameboard: Gameboard) -> GameboardPosition? {

		if moveCounter == -1 {
			allBoardMovesArray.removeAll()
			firstPlayerArray.removeAll()
			secondPlayerArray.removeAll()
			pushArray()
		}

		if moveCounter == 9 {
			position = secondPlayerArray.first ?? GameboardPosition(column: 0, row: 0)
			moveCounter = -1
			return position
		} else {
			moveCounter += 1
			if moveCounter % 2 == 0 || moveCounter == 0 {
				position = firstPlayerArray.first ?? GameboardPosition(column: 0, row: 0)
				firstPlayerArray.removeFirst()
				return position
			} else {
				position = secondPlayerArray.first ?? GameboardPosition(column: 0, row: 0)
				if moveCounter < 9 {
					secondPlayerArray.removeFirst()
				}
				return position
			}
		}
	}
}
