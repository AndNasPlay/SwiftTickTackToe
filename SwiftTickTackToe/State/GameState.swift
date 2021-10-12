//
//  GameState.swift
//  SwiftTickTackToe
//
//  Created by Андрей Щекатунов on 12.10.2021.
//

import Foundation

protocol GameState {

	var isMoveCompleted: Bool { get }

	func begin()
	func addMark(at position: GameboardPosition)

}
