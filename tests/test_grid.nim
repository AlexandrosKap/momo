import unittest
import momo/grid

const width = 4
const height = 4

test "Grid":
  check point(0, 0) == Point(x: 0, y: 0)
  check point(0) == point(0, 0)
  check point() == point(0)

  check newBGrid(1, 1, true).cells == @[true]
  check newBGrid(1, 1).cells == @[false]

  var grid = newBGrid(width, height)
  check grid.width == width
  check grid.height == height
  check grid.cells == newSeq[bool](width * height)
  check grid.len == width * height

  check grid.id(0, 0) == 0
  check grid.id(point()) == 0

  check grid.point(0) == point()

  grid.set(0, true)
  grid.set(0, 0, true)
  grid.set(point(), true)
  check grid.get(0) == true
  check grid.get(0, 0) == true
  check grid.get(point()) == true

  grid.swap(0, grid.len - 1)
  grid.swap(0, 0, grid.width - 1, grid.height - 1)
  grid.swap(point(), point(grid.width - 1, grid.height - 1))
  check grid.get(grid.width - 1, grid.height - 1) == true

  grid.fill(false)
  grid.fill(0, 0, grid.width - 1, grid.height - 1, false)
  grid.fill(point(), point(grid.width - 1, grid.height - 1), false)
  grid.fill(0, grid.len - 1, false)
  check grid.get(grid.width - 1, grid.height - 1) == false

  grid.enclose(true)
  grid.enclose(0, 0, grid.width - 1, grid.height - 1, true)
  grid.enclose(point(), point(grid.width - 1, grid.height - 1), true)
  grid.enclose(0, grid.len - 1, true)
  check grid.get(0) == true

  grid.clear()
  grid.clear(0, 0, grid.width - 1, grid.height - 1)
  grid.clear(point(), point(grid.width - 1, grid.height - 1))
  grid.clear(0, grid.len - 1)
  check grid.get(0) == false

  check grid.isEmpty(0) == true
  check grid.isEmpty(0, 0) == true
  check grid.isEmpty(point()) == true

  check grid.isInside(0) == true
  check grid.isInside(0, 0) == true
  check grid.isInside(point()) == true

  check grid == newBGrid(width, height)

  for cell in grid:
    check cell == false
  for i, cell in grid:
    check cell == false
