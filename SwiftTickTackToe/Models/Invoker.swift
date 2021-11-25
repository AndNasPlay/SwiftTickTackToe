//
//  Invoker.swift
//  SwiftTickTackToe
//
//  Created by Андрей Щекатунов on 19.11.2021.
//

import Foundation

final class Invoker {

	static let shared = Invoker()

	private var firstPlayerCommands: [Command] = []

	private var secondPlayerCommands: [Command] = []

	private var markCounter: Int = 5

	public var gameEnd: Bool = false

	public func addCommand(player: Player, command: Command) {
		gameEnd = false
		switch player {
		case .first:
			firstPlayerCommands.append(command)
		default:
			secondPlayerCommands.append(command)
		}
	}

	public func executeGame() {
		for counter in 0..<markCounter {
			self.firstPlayerCommands[counter].execute(delay: 1.0 + Double(counter))
			self.secondPlayerCommands[counter].execute(delay: 1.5 + Double(counter))
		}
		gameOver()
	}

	private func gameOver() {
		gameEnd = true
		self.firstPlayerCommands.removeAll()
		self.secondPlayerCommands.removeAll()
	}
}
