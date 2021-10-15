//
//  GameVsComputerState.swift
//  SwiftTickTackToe
//
//  Created by Андрей Щекатунов on 14.10.2021.
//

import Foundation

protocol GameVsComputerState {

	var isMoveCompleted: Bool { get }

	func begin()
	func addMark(at position: GameboardPosition)
	func addComputerMark(at position: GameboardPosition)

}
