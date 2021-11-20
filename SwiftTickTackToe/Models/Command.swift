//
//  Command.swift
//  SwiftTickTackToe
//
//  Created by Андрей Щекатунов on 19.11.2021.
//

import Foundation

protocol Command {
	func execute()
}

class MarkFromCommand: Command {

	private let player: Player
	private let position: GameboardPosition
	private let viewController: GameViewController

	init(player: Player, position: GameboardPosition, context: GameViewController) {
		self.player = player
		self.position = position
		self.viewController = context
	}

	func execute() {

		viewController.gameBoard.setPlayer(self.player, at: position)
		DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
			let markView: MarkView
			switch self.player {
			case .first:
				markView = XView()
			case .second:
				markView = OView()
			default:
				return
			}
			if !(self.viewController.gameboardView.canPlaceMarkView(at: self.position)) {
				self.viewController.gameboardView.removeMarkView(at: self.position)
			}
			self.viewController.gameboardView.placeMarkView(markView, at: self.position)
		}
	}
}
