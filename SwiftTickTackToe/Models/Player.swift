//
//  Player.swift
//  SwiftTickTackToe
//
//  Created by Андрей Щекатунов on 12.10.2021.
//

import Foundation

public enum Player: CaseIterable {
	case first
	case second
	case computer

	func next(gameType: GameType) -> Player {
		switch gameType {
		case .singlePlayer:
			switch self {
			case .first: return .computer
			case .computer: return .first
			default: return .first
			}
		case .multiplayer:
			switch self {
			case .first: return .second
			case .second: return .first
			default: return .first
			}
		case .fiveSteps:
			switch self {
			case .first:
				if GameboardState.shared.allGameboardPositions.count <= 4 {
					return .first
				} else {
					return .second
				}
			case .second:
				if GameboardState.shared.allGameboardPositions.count > 4 {
					return .second
				} else {
					return .first
				}
			default: return .first
			}
		}
	}
}
