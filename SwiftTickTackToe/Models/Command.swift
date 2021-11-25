//
//  Command.swift
//  SwiftTickTackToe
//
//  Created by Андрей Щекатунов on 19.11.2021.
//

import Foundation

protocol Command {
	func execute(delay: Double)
}

class MarkFromCommand: Command {

	private let player: Player

	private let position: GameboardPosition

	private let viewController: GameViewController

	init(player: Player, position: GameboardPosition, viewController: GameViewController) {
		self.player = player
		self.position = position
		self.viewController = viewController
	}

	func execute(delay: Double) {
		viewController.gameBoard.setPlayer(self.player, at: position)
		DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
			let markView: MarkView
			switch self.player {
			case .first:
				markView = XView()
				self.viewController.newView.firstPlayerStackView.isHidden = false
				self.viewController.newView.secondPlayerStackView.isHidden = true
			case .second:
				markView = OView()
				self.viewController.newView.firstPlayerStackView.isHidden = true
				self.viewController.newView.secondPlayerStackView.isHidden = false
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
