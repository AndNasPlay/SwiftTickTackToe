//
//  ComputerMovesAlgorithm.swift
//  SwiftTickTackToe
//
//  Created by Андрей Щекатунов on 25.10.2021.
//

import Foundation

struct move {
	var index: [Int]?
	var score: [Int]?
}

class ComputerMovesAlgorithm {

	var origBoard = [22, 1 , 33, 33, 4 , 33, 6 ,22, 22]

	// человек
	var huPlayer = 22

	// ИИ
	var aiPlayer = 33

	// возвращает список индексов пустых клеток доски
	func emptyIndices(board: [Int]) -> [Int] {
		return  board.filter { $0 != 22 && $0 != 33 }
	}

	// победные комбинации с учётом индексов
	func winning(board: [Int], player: Int)-> Bool {
		if(
			(board[0] == player && board[1] == player && board[2] == player) ||
				(board[3] == player && board[4] == player && board[5] == player) ||
				(board[6] == player && board[7] == player && board[8] == player) ||
				(board[0] == player && board[3] == player && board[6] == player) ||
				(board[1] == player && board[4] == player && board[7] == player) ||
				(board[2] == player && board[5] == player && board[8] == player) ||
				(board[0] == player && board[4] == player && board[8] == player) ||
				(board[2] == player && board[4] == player && board[6] == player)
		)
		{
			return true
		} else {
			return false
		}
	}

	// основная минимакс-функция
	func minimax(newBoard: [Int], player: Int) -> Int {

		var newNewBoard: [Int] = newBoard

		let availSpots = emptyIndices(board: newBoard)

		if (winning(board: newBoard, player: huPlayer)) {
			return -10
		} else if (winning(board: newBoard, player: aiPlayer)) {
			return 10
		} else if availSpots.count == 0 {
			return 0
		}
		// массив для хранения всех объектов
		var moves: [move] = []
		// цикл по доступным клеткам
		for i in 0...availSpots.count {
			var move: move
			move.index?.append(newBoard[availSpots[i]])
			// совершить ход за текущего игрока
			newNewBoard[availSpots[i]] = player

			//получить очки, заработанные после вызова минимакса от противника текущего игрока
			if (player == aiPlayer){
				var result = minimax(newBoard: newNewBoard, player: huPlayer)
				move.score?.append(result)
			} else {
				var result = minimax(newBoard: newNewBoard, player: aiPlayer)
				move.score?.append(result)
			}
			// очистить клетку
			newNewBoard[availSpots[i]] = (move.index?.first)!;
			// положить объект в массив
			moves.append(move)
		}

	// если это ход ИИ, пройти циклом по ходам и выбрать ход с наибольшим количеством очков
	  var bestMove = 0
	  if (player == aiPlayer) {
		var bestScore = -10000;
		for i in 0...moves.count {
			if(moves[i].score > bestScore){
			bestScore = moves[i].score;
			bestMove = i;
		  }
		}
	  }else{

	// иначе пройти циклом по ходам и выбрать ход с наименьшим количеством очков
		var bestScore = 10000;
		for(var i = 0; i < moves.length; i++){
		  if(moves[i].score < bestScore){
			bestScore = moves[i].score;
			bestMove = i;
		  }
		}
	  }

	// вернуть выбранный ход (объект) из массива ходов
	  return moves[bestMove];
	}
}
