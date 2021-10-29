//
//  ComputerMovesAlgorithm.swift
//  SwiftTickTackToe
//
//  Created by Андрей Щекатунов on 25.10.2021.
//

import Foundation

public class ComputerMovesAlgorithm {

	var human = 22
	var computer = 33

	func emptyIndices(board: [Int]) -> [Int] {
		return  board.filter { $0 != human && $0 != computer }
	}

	func winningCombination(board: [Int], player: Int) -> Bool {
		if  (board[0] == player && board[1] == player && board[2] == player) ||
			(board[3] == player && board[4] == player && board[5] == player) ||
			(board[6] == player && board[7] == player && board[8] == player) ||
			(board[0] == player && board[3] == player && board[6] == player) ||
			(board[1] == player && board[4] == player && board[7] == player) ||
			(board[2] == player && board[5] == player && board[8] == player) ||
			(board[0] == player && board[4] == player && board[8] == player) ||
			(board[2] == player && board[4] == player && board[6] == player) {
			return true
		} else {
			return false
		}
	}

	func minimax(newBoard: [Int], player: Int) -> Move {

		var newNewBoard: [Int] = newBoard

		let availSpots = emptyIndices(board: newNewBoard)

		if winningCombination(board: newNewBoard, player: human) {
			return Move(score: -10)
		} else if winningCombination(board: newNewBoard, player: computer) {
			return Move(score: 10)
		} else if availSpots.count == 0 {
			return Move(score: 0)
		}

		var moves: [Move] = []

		for counter in 0...availSpots.count - 1 {
			var move: Move = Move(index: 0, score: 0)
			move.index = newNewBoard[availSpots[counter]]
			newNewBoard[availSpots[counter]] = player

			if player == computer {
				let result = minimax(newBoard: newNewBoard, player: human)
				move.score = result.score
			} else {
				let result = minimax(newBoard: newNewBoard, player: computer)
				move.score = result.score
			}

			newNewBoard[availSpots[counter]] = move.index!
			moves.append(move)
		}

		var bestMove = Int()
		if player == computer {
			var bestScore = -10000
			for counter in 0...moves.count - 1  where (moves[counter].score) > bestScore {
				bestScore = (moves[counter].score)
				bestMove = counter
			}
		} else {

			var bestScore = 10000
			for counter in 0...moves.count - 1 where (moves[counter].score) < bestScore {
				bestScore = (moves[counter].score)
				bestMove = counter

			}
		}
		return (moves[bestMove])
	}

	func replace(array: [Int], position: Int, value: Int) -> [Int] {
		var newArray = array
		newArray.remove(at: position)
		newArray.insert(value, at: position)
		return newArray
	}

	func switcher (
		oldIntGameboardPositions: [Int],
		gameboardPositions: [GameboardPosition],
		normalPosition: Int, player: Int ) -> [Int] {

		var intGameboardPositions = oldIntGameboardPositions

		if returnGameboardPosition().contains(gameboardPositions[normalPosition]) {
			intGameboardPositions = replace(array: intGameboardPositions,
											position: returnGameboardPosition().firstIndex {
												$0 == gameboardPositions[normalPosition]
											}!,
											value: player)
		}

		return intGameboardPositions
	}

	func prepareForMinimax(gameboardPositions: [GameboardPosition]) -> [Int] {
		let huPlayer = 22
		let aiPlayer = 33
		var intGameboardPositions: [Int] = []
		let gameboardSizeColumns: Int = GameboardSize.columns
		let gameboardSizeRows: Int = GameboardSize.rows
		let gameboardSize: Int = gameboardSizeColumns * gameboardSizeRows
		for counter in 0...gameboardSize - 1 {
			intGameboardPositions.append(counter)
		}
		for normalPosition in 0...gameboardPositions.count - 1 {
			if normalPosition % 2 == 0 || normalPosition == 0 {

				intGameboardPositions = switcher(oldIntGameboardPositions: intGameboardPositions,
												 gameboardPositions: gameboardPositions,
												 normalPosition: normalPosition,
												 player: huPlayer)

			} else {

				intGameboardPositions = switcher(oldIntGameboardPositions: intGameboardPositions,
												 gameboardPositions: gameboardPositions,
												 normalPosition: normalPosition,
												 player: aiPlayer)

			}
		}
		return intGameboardPositions
	}

	func prepareForBoard(gameboardPositions: Move) -> GameboardPosition {
		var bestPosition: GameboardPosition = GameboardPosition(column: 0, row: 0)
		switch gameboardPositions.index {
		case 0:
			bestPosition = GameboardPosition(column: 0, row: 0)
		case 1:
			bestPosition = GameboardPosition(column: 1, row: 0)
		case 2:
			bestPosition = GameboardPosition(column: 2, row: 0)
		case 3:
			bestPosition = GameboardPosition(column: 0, row: 1)
		case 4:
			bestPosition = GameboardPosition(column: 1, row: 1)
		case 5:
			bestPosition = GameboardPosition(column: 2, row: 1)
		case 6:
			bestPosition = GameboardPosition(column: 0, row: 2)
		case 7:
			bestPosition = GameboardPosition(column: 1, row: 2)
		case 8:
			bestPosition = GameboardPosition(column: 2, row: 2)
		default:
			break
		}
		return bestPosition
	}

	func returnGameboardPosition() -> [GameboardPosition] {
		var newArray: [GameboardPosition] = []
		var counter = 0
		while counter < GameboardSize.rows {
			for counterColumn in 0...GameboardSize.columns - 1 {
				newArray.append(GameboardPosition(column: counterColumn, row: counter))
			}
			counter += 1
		}

		return newArray
	}

	func returnIntOnGameboardPosition() -> [Int] {
		var newArray: [Int] = []
		var counter = 0
		while counter < GameboardSize.rows * GameboardSize.columns {
			newArray.append(counter)
			counter += 1
		}
		return newArray
	}
}
