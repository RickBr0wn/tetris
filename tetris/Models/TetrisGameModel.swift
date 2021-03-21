//
//  TetrisGameModel.swift
//  tetris
//
//  Created by Rick Brown on 20/03/2021.
//

import SwiftUI

class TetrisGameModel: ObservableObject {
  var numberOfRows: Int
  var numberOfColumns: Int
  
  @Published var gameBoard: [[TetrisGameBlock?]]
  @Published var tetromino: Tetromino?
  
  init(numberOfRows: Int = 23, numberOfColumns: Int = 10) {
    self.numberOfRows = numberOfRows
    self.numberOfColumns = numberOfColumns
    // create a 2d array to hold the gameboard
    // gameBoard[x][y]
    self.gameBoard = Array(repeating: Array(repeating: nil, count: numberOfRows), count: numberOfColumns)
    self.tetromino = Tetromino(origin: BlockLocation(row: 22, column: 4), blockType: .i)
  }
  
  func blockClicked(row: Int, column: Int) {
    print("Column: \(column), Row: \(row)")
    if gameBoard[column][row] == nil {
      gameBoard[column][row] = TetrisGameBlock(blockType: BlockType.allCases.randomElement()!)
    } else {
      gameBoard[column][row] = nil
    }
  }
}

struct TetrisGameBlock {
  var blockType: BlockType
}

// type of tetromino
// see: https://tetris.fandom.com/wiki/Tetromino
enum BlockType: CaseIterable {
  case i, o, t, s, z, j, l
}

struct Tetromino {
  var origin: BlockLocation
  var blockType: BlockType
  
  var blocks: [BlockLocation] {
    [
      BlockLocation(row: 0, column: -1),
      BlockLocation(row: 0, column: 0),
      BlockLocation(row: 0, column: 1),
      BlockLocation(row: 0, column: 2)
    ]
  }
}

struct BlockLocation {
  var row: Int
  var column: Int
}
