//
//  TetrisGameView.swift
//  tetris
//
//  Created by Rick Brown on 19/03/2021.
//

import SwiftUI

struct TetrisGameView: View {
  // craete a copy of the view model
  @ObservedObject var tetrisGame = TetrisGameViewModel()
  
  var body: some View {
    // use a geometry reader to get the size of the parent view (the screen)
    GeometryReader { (geometry: GeometryProxy) in
      // create and call the function, this enables declaring new variables
      self.drawBoard(ofSize: geometry.size)
    }
  }
  
  // draw the game board
  func drawBoard(ofSize rectangle: CGSize) -> some View {
    // define the rows & columns according to the vioew model
    let columns = self.tetrisGame.numberOfColumns
    let rows = self.tetrisGame.numberOfRows
    // now find the smallest, and use this as the blockSize
    let blockSize = min(rectangle.width / CGFloat(columns), rectangle.height / CGFloat(rows))
    // calculate the required padding to centralise the game board
    let xOffset = (rectangle.width - blockSize * CGFloat(columns)) / 2
    let yOffset = (rectangle.height - blockSize * CGFloat(rows)) / 2
    // return an iteration over the whole game board to assertain which color will be drawn
    return ForEach(0...columns - 1, id: \.self) { (column: Int) in
      ForEach(0...rows - 1, id: \.self) { (row: Int) in
        // use Path to draw a rectangle
        Path { path in
          let x = xOffset + blockSize * CGFloat(column)
          let y = rectangle.height - yOffset - blockSize * CGFloat(row + 1)
          
          let rect = CGRect(x: x, y: y, width: blockSize, height: blockSize)
          path.addRect(rect)
        }
        .fill(self.tetrisGame.gameBoard[column][row].color)
        .onTapGesture {
          self.tetrisGame.squareClicked(row: row, column: column)
        }
      }
    }
  }
}

struct TetrisGameView_Previews: PreviewProvider {
  static var previews: some View {
    TetrisGameView()
  }
}
