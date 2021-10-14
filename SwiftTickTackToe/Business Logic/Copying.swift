//
//  Copying.swift
//  SwiftTickTackToe
//
//  Created by Андрей Щекатунов on 12.10.2021.
//

import Foundation

protocol Copying: AnyObject {
	init(_ prototype: Self)
}

extension Copying where Self: AnyObject {
	func copy() -> Self {
		return type(of: self).init(self)
	}
}
