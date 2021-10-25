//
//  GameTypeState.swift
//  SwiftTickTackToe
//
//  Created by Андрей Щекатунов on 25.10.2021.
//

import Foundation

class GameTypeState {

	func checkState(gameType: GameType, viewController: GameViewController) -> GameState {
		switch gameType {
		case .multiplayer:
			return PlayerState(player: .first, gameViewController: viewController)
		case .singlePlayer:
			return ComputerState(player: .first, viewController: viewController)
		}
	}

}
