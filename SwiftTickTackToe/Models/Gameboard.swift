//
//  Gameboard.swift
//  SwiftTickTackToe
//
//  Created by Андрей Щекатунов on 12.10.2021.
//

import Foundation

public final class Gameboard {

	private lazy var positions: [[Player?]] = initialPositions()

	public func setPlayer(_ player: Player, at position: GameboardPosition) {
		positions[position.column][position.row] = player
	}

	public func clear() {
		self.positions = initialPositions()
	}

	public func contains(player: Player, at positions: [GameboardPosition]) -> Bool {
		for position in positions {
			guard contains(player: player, at: position) else {
				return false
			}
		}
		return true
	}

	public func contains(player: Player, at position: GameboardPosition) -> Bool {
		let (column, row) = (position.column, position.row)
		return positions[column][row] == player
	}

	public func contains(at position: GameboardPosition) -> Player? {
		let (column, row) = (position.column, position.row)
		return positions[column][row]
	}

	public func noMoreSteps() -> Bool {
		return positions.flatMap { $0 }.allSatisfy { $0 != nil }
	}

	public func noMoreStepsForFiveSteps() -> Bool {
		return GameboardState.shared.allGameboardPositions.count == 20
	}

	private func initialPositions() -> [[Player?]] {
		var positions: [[Player?]] = []
		for _ in 0 ..< GameboardSize.columns {
			let rows = [Player?](repeating: nil, count: GameboardSize.rows)
			positions.append(rows)
		}
		return positions
	}
}
