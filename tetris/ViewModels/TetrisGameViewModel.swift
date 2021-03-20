//
//  TetrisGameViewModel.swift
//  tetris
//
//  Created by Rick Brown on 19/03/2021.
//

import SwiftUI

class TetrisGameViewModel: ObservableObject {
  var numberOfRows: Int
  var numberOfColumns: Int
  
  @Published var gameBoard: [[TetrisGameSquare]]
  
  init(numberOfRows: Int = 23, numberOfColumns: Int = 10) {
    self.numberOfRows = numberOfRows
    self.numberOfColumns = numberOfColumns
    
    // create a 2d array to hold the gameboard
    // gameBoard[x][y]
    gameBoard = Array(repeating:
                        Array(repeating:
                                TetrisGameSquare(color: Color.tetrisBlack), count: numberOfRows), count: numberOfColumns)
  }
  
  // a method to handle the clicking of a square on thge game board
  func squareClicked(row: Int, column: Int) {
    print("Column: \(column), Row: \(row)")
    if gameBoard[column][row].color == Color.tetrisBlack {
      gameBoard[column][row].color = Color.tetrisRed
    } else {
      gameBoard[column][row].color = Color.tetrisBlack
    }
  }
}

struct TetrisGameSquare {
  var color: Color
}
