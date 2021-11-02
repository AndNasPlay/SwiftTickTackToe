//
//  ComputerMovesAlgorithmTest.swift
//  SwiftTickTackToeTests
//
//  Created by Андрей Щекатунов on 01.11.2021.
//

import XCTest
@testable import SwiftTickTackToe

class ComputerMovesAlgorithmTest: XCTestCase {

	let testComputerMoves = ComputerMovesAlgorithm()

	var human = 22
	var computer = 33

	func testEmptyIndices() throws {
		let board = [human, 1, 2, 3, computer, 5, 6, 7, human]
		let testMethod = try XCTUnwrap(testComputerMoves.emptyIndices(board: board))
		XCTAssertEqual(testMethod.count, 6)
	}

	func testWinningCombination() throws {
		let board = [human, 1, human, 3, computer, 5, computer, 7, human]
		let testMethod = try XCTUnwrap(testComputerMoves.winningCombination(board: board, player: human))
		XCTAssertEqual(testMethod, false)
	}

	func testMiniMax() throws {
		let board = [human, 1, human, 3, human, 5, computer, 7, computer]
		let bestMove = Move(index: 7, score: 10)
		let testMethod = try XCTUnwrap(testComputerMoves.minimax(newBoard: board, player: computer))
		XCTAssertTrue(testMethod.index == bestMove.index)
		XCTAssertEqual(testMethod.index, bestMove.index)
	}

	func testReplace() throws {
		let board: [Int] = [0, 1, 2, 3, 4, 5, 6, 7, 8]
		let position: Int = Int.random(in: 0...8)
		let value: Int = human
		let testMethod = try XCTUnwrap(testComputerMoves.replace(array: board,
										position: position,
										value: value))
		XCTAssertTrue(testMethod.count == 9)
		XCTAssertEqual(testMethod[position], value)
	}

	func testPrepareForMinimax() throws {

		let arrPosition = [
			GameboardPosition(column: 0, row: 0),
			GameboardPosition(column: 1, row: 1),
			GameboardPosition(column: 2, row: 2)
		]
		let testMethod = try XCTUnwrap(testComputerMoves.prepareForMinimax(gameboardPositions: arrPosition))
		let testIntArr = [22, 1, 2, 3, 33, 5, 6, 7, 22]
		XCTAssertEqual(testMethod, testIntArr)
		XCTAssertEqual(testMethod.count, 9)
	}

	func testPrepareForBoard() throws {
		let move = Move(index: 3, score: 10)
		let testMethod = try XCTUnwrap(testComputerMoves.prepareForBoard(gameboardPositions: move))
		let testPosition = GameboardPosition(column: 0, row: 1)
		XCTAssertEqual(testMethod, testPosition)
	}

	func testReturnGameboardPosition() throws {
		let testMethod = try XCTUnwrap(testComputerMoves.returnGameboardPosition)
		XCTAssertEqual(testMethod().count, 9)
	}
}
