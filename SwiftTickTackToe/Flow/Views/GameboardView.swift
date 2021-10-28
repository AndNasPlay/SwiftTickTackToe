//
//  GameboardView.swift
//  SwiftTickTackToe
//
//  Created by Андрей Щекатунов on 11.10.2021.
//

import UIKit

public class GameboardView: UIView {

	public var onSelectPosition: ((GameboardPosition) -> Void)?

	public private(set) var markViewForPosition: [GameboardPosition: MarkView] = [:]

	override init(frame: CGRect) {
		super.init(frame: frame)
		self.translatesAutoresizingMaskIntoConstraints = false
		self.backgroundColor = .viewBackgroundColor
	}

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		self.translatesAutoresizingMaskIntoConstraints = false
		self.backgroundColor = .viewBackgroundColor
	}

	internal struct Constants {
		static let lineColor: UIColor = .boardLineColor
		static let lineWidth: CGFloat = 6
	}

	private var calculatedColumnWidth: CGFloat {
		return bounds.width / CGFloat(GameboardSize.columns)
	}
	private var calculatedRowHeight: CGFloat {
		return bounds.height / CGFloat(GameboardSize.rows)
	}

	public func clear() {
		for (_, markView) in markViewForPosition {
			markView.removeFromSuperview()
		}
		markViewForPosition = [:]
	}

	public func canPlaceMarkView(at position: GameboardPosition) -> Bool {
		return markViewForPosition[position] == nil
	}

	public func placeMarkView(_ markView: MarkView, at position: GameboardPosition) {
		guard self.canPlaceMarkView(at: position) else { return }
		updateFrame(for: markView, at: position)
		markViewForPosition[position] = markView
		GameboardState.shared.addMove(gameboardPosition: position)
		addSubview(markView)
	}

	public func removeMarkView(at position: GameboardPosition) {
		guard let markView = markViewForPosition[position] else {
			return
		}
		markViewForPosition[position] = nil
		markView.removeFromSuperview()
	}

	public override func draw(_ rect: CGRect) {
		super.draw(rect)
		Constants.lineColor.setStroke()
		drawColumnLines(for: rect)
		drawRowLines(for: rect)
	}

	public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
		guard let touchLocation = touches.first?.location(in: self) else { return }
		let position = GameboardPosition(column: determineColumn(for: touchLocation),
										 row: determineRow(for: touchLocation))
		onSelectPosition?(position)
	}

	private func drawColumnLines(for rect: CGRect) {
		let columnWidth = self.calculatedColumnWidth
		for place in 1 ..< GameboardSize.columns {
			let linePath = UIBezierPath()
			linePath.move(to: CGPoint(x: rect.minX + CGFloat(place) * columnWidth,
									  y: rect.minY))
			linePath.addLine(to: CGPoint(x: rect.minX + CGFloat(place) * columnWidth,
										 y: rect.minY + rect.height))
			linePath.lineWidth = Constants.lineWidth
			linePath.stroke()
		}
	}

	private func drawRowLines(for rect: CGRect) {
		let rowHeight = self.calculatedRowHeight
		for place in 1 ..< GameboardSize.rows {
			let linePath = UIBezierPath()
			linePath.move(to: CGPoint(x: rect.minX, y: rect.minY + CGFloat(place) * rowHeight))
			linePath.addLine(to: CGPoint(x: rect.minX + rect.width, y: rect.minY + CGFloat(place) * rowHeight))
			linePath.lineWidth = Constants.lineWidth
			linePath.stroke()
		}
	}

	private func determineColumn(for touchLocation: CGPoint) -> Int {
		let columnWidth = self.calculatedColumnWidth
		let lastColumn = GameboardSize.columns - 1
		for place in (0 ..< lastColumn) {
			let xMin = CGFloat(place) * columnWidth
			let xMax = CGFloat(place + 1) * columnWidth
			if (xMin ..< xMax).contains(touchLocation.x) {
				return place
			}
		}
		return lastColumn
	}

	private func determineRow(for touchLocation: CGPoint) -> Int {
		let rowHeight = self.calculatedRowHeight
		let lastRow = GameboardSize.rows - 1
		for place in (0 ..< lastRow) {
			let yMin = CGFloat(place) * rowHeight
			let yMax = CGFloat(place + 1) * rowHeight
			if (yMin ..< yMax).contains(touchLocation.y) {
				return place
			}
		}
		return lastRow
	}

	private func updateFrame(for markView: MarkView, at position: GameboardPosition) {
		let columnWidth = self.calculatedColumnWidth
		let rowHeight = self.calculatedRowHeight
		markView.frame = CGRect(x: CGFloat(position.column) * columnWidth,
								y: CGFloat(position.row) * rowHeight,
								width: columnWidth,
								height: rowHeight).insetBy(dx: 0.5 * Constants.lineWidth,
														   dy: 0.5 * Constants.lineWidth)
	}
}
