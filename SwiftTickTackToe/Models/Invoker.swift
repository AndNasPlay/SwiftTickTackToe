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

	public func addCommand(player: Player, command: Command) {
		switch player {
		case .first:
			firstPlayerCommands.append(command)
		default:
			secondPlayerCommands.append(command)
		}
	}

	public func executeGame() {
		let size = firstPlayerCommands.count

		for counter in 0..<size {
			self.firstPlayerCommands[counter].execute()
			self.secondPlayerCommands[counter].execute()
		}
	}
}
