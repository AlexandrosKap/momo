## The Game of Life made with the grid module.

from os import sleep
import momo/grid

const genCount = 20
const sleepTime = 500
const size = ivec2(8, 8)

func newBoard(): BGrid =
  ## Creates a new board.
  newBGrid(size)

func newPreBoard(): BGrid =
  ## Creates a new predefined board.
  result = newBoard()
  result.fill(ivec2(2, 0), ivec2(2, 2), true)
  result.set(ivec2(0, 1), true)
  result.set(ivec2(1, 2), true)

func update(self: BGrid) =
  ## Updates the state of the board.
  var temp = newBoard()
  for p, cell in self:
    temp.set(p, cell)
  # Update every cell.
  for p, cell in temp:
    var hp = 0
    for n in p.neighbors:
      if n != p and temp.isInside(n) and temp.get(n):
        hp += 1
    if cell and (hp <= 1 or hp >= 4):
      self.set(p, false)
    elif hp == 3:
      self.set(p, true)

when isMainModule:
  var board = newPreBoard()
  echo board, "\n"
  sleep(sleepTime)
  for i in 1 .. genCount:
    board.update()
    echo board
    if i != genCount:
      echo ""
      sleep(sleepTime)
