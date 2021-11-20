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
	case autoStepFirst
	case autoStepSecond

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
			if GameboardState.shared.allGameboardPositions.count <= 4 {
				return .first
			} else if GameboardState.shared.allGameboardPositions.count < 10 {
				return .second
			} else {
				switch self {
				case .autoStepFirst: return .autoStepSecond
				case .autoStepSecond: return .autoStepFirst
				default: return .autoStepFirst
				}
			}
		}
	}
}
