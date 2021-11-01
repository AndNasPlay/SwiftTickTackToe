//
//  ComputerMovesAlgorithmTest.swift
//  SwiftTickTackToeTests
//
//  Created by Андрей Щекатунов on 01.11.2021.
//

import XCTest
@testable import SwiftTickTackToe

class ComputerMovesAlgorithmTest: XCTestCase {

	func testPrepareForMinimax() throws {
		let testComputerMoves = ComputerMovesAlgorithm()
		let arrPosition = [
			GameboardPosition(column: 0, row: 0),
			GameboardPosition(column: 1, row: 1),
			GameboardPosition(column: 2, row: 2)
		]
		let textMethod = try XCTUnwrap(testComputerMoves.prepareForMinimax(gameboardPositions: arrPosition))
		let testIntArr = [22, 1, 2, 3, 33, 5, 6, 7, 22]
		XCTAssertEqual(textMethod, testIntArr)
	}

}
