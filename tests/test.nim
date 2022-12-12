import unittest
import momo/[color, grid]

test "Color":
  check toByte("") == uint8.low
  check toByte("67") != uint8.low
  check color(0, 0, 0, 0) == Color()
  check color(0, 0, 0) == color(0, 0, 0, uint8.high)
  check color(0) == color(0, 0, 0, uint8.high)
  check color("") == color(0)
  check color("-") == color(0)
  check color("67") == color(0)
  check color("e6d250") == color(230, 210, 80)
  check color("#e6d250") == color(230, 210, 80)
  check color("5aff5d78") == color(255, 93, 120, 90)
  check color("#5aff5d78") == color(255, 93, 120, 90)

const width = 2u
const height = 2u
const area = width * height
const firstPoint = (0u, 0u)
const secondPoint = (1u, 0u)
const lastPoint = (width - 1, height - 1)
const cells = array[area, bool].default

proc grid(): BGrid = newBGrid(width, height)

test "Grid":
  let grid = grid()
  check point(2, 4) == (2u, 4u)
  check point(1) == (1u, 1u)
  check point() == (0u, 0u)

  check grid.width == width
  check grid.height == height
  check grid.cells == cells
  check grid.len == area

  check grid.id(0, 0) == 0
  check grid.id(firstPoint) == 0
  check grid.id(width - 1, height - 1) == area - 1
  check grid.id(lastPoint) == area - 1

  check grid.point(area - 1) == lastPoint

  grid.set(0, true)
  check grid.get(0) == true
  grid.set(0, 0, false)
  check grid.get(0, 0) == false
  grid.set(firstPoint, true)
  check grid.get(firstPoint) == true

  grid.swap(0, 1)
  check grid.get(0) == false
  grid.swap(0, 0, 1, 0)
  check grid.get(0) == true
  grid.swap(firstPoint, secondPoint)
  check grid.get(0) == false

  grid.fill(true)
  for cell in grid.cells:
    check cell == true
  # TODO: Fix bug with fill and add more tests
  grid.fill(0, area - 1, false)
  echo grid.cells
  for cell in grid.cells:
    check cell == false
