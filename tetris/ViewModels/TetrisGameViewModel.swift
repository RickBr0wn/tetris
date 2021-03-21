//
//  TetrisGameViewModel.swift
//  tetris
//
//  Created by Rick Brown on 19/03/2021.
//

import SwiftUI
import Combine

class TetrisGameViewModel: ObservableObject {
  // pubish the tetrisGameModel
  @Published var tetrisGameModel = TetrisGameModel()
  // define the number of rows and columns
  var numberOfRows: Int { tetrisGameModel.numberOfRows }
  var numberOfColumns: Int { tetrisGameModel.numberOfColumns }
  // create a game board
  var gameBoard: [[TetrisGameSquare]] {
    var board = tetrisGameModel.gameBoard.map { $0.map(convertToSquare) }
    
    if let tetromino = tetrisGameModel.tetromino {
      for blockLocation in tetromino.blocks {
        board[blockLocation.column + tetromino.origin.column][blockLocation.row + tetromino.origin.row] = TetrisGameSquare(color: getColor(blockType: tetromino.blockType))
      }
    }
    
    return board
  }
  // using combine to syncronize the view model and the model (they are both Observable Objects)
  var anyCancellable: AnyCancellable?
  // (i think) this fires TetrisGameViewModel's publisher when the TetrisGameModel's publisher fires
  init() {
    anyCancellable = tetrisGameModel.objectWillChange.sink {
      self.objectWillChange.send()
    }
  }
  // convert a TetrisGameBlock (from TetrisGameModel) into a TetrisGameSqure
  func convertToSquare(block: TetrisGameBlock?) -> TetrisGameSquare {
    return TetrisGameSquare(color: getColor(blockType: block?.blockType))
  }
  // get the correct color for each tetromino
  func getColor(blockType: BlockType?) -> Color {
    switch blockType {
    case .i:
      return .tetrisLightBlue
    case .j:
      return .tetrisDarkBlue
    case .l:
      return .tetrisOrange
    case .o:
      return .tetrisYellow
    case .s:
      return .tetrisGreen
    case .t:
      return .tetrisPurple
    case .z:
      return .tetrisRed
    case .none:
      return.tetrisBlack
    }
  }
  // a method to handle the clicking of a square on thge game board
  func squareClicked(row: Int, column: Int) {
    tetrisGameModel.blockClicked(row: row, column: column)
  }
  
}

struct TetrisGameSquare {
  var color: Color
}
