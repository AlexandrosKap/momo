from strformat import `&`
from strutils import fromHex
import vector
export vector

type
  Color* = Vec4
  Palette* = seq[Color]
  Grayscale* = seq[float32]

# Helper Functions

func toByte*(hex: string): uint8 =
  try:
    fromHex[uint8](hex)
  except ValueError:
    0

# Constructors and Operators

func color*(r, g, b, a: float32): Color =
  Color(x: r, y: g, z: b, w: a)

func color*(r, g, b: float32): Color =
  Color(x: r, y: g, z: b, w: 1)

func color*(r: float32): Color =
  Color(x: r, y: r, z: r, w: 1)

func color*(): Color =
  Color(w: 1)

func color*(hex: string): Color =
  case hex.len:
  of 6:
    Color(
      x: hex[0 .. 1].toByte.float32 / 255,
      y: hex[2 .. 3].toByte.float32 / 255,
      z: hex[4 .. 5].toByte.float32 / 255,
      w: 1
    )
  of 7:
    Color(
      x: hex[1 .. 2].toByte.float32 / 255,
      y: hex[3 .. 4].toByte.float32 / 255,
      z: hex[5 .. 6].toByte.float32 / 255,
      w: 1
    )
  of 8:
    Color(
      x: hex[2 .. 3].toByte.float32 / 255,
      y: hex[4 .. 5].toByte.float32 / 255,
      z: hex[6 .. 7].toByte.float32 / 255,
      w: hex[0 .. 1].toByte.float32 / 255
    )
  of 9:
    Color(
      x: hex[3 .. 4].toByte.float32 / 255,
      y: hex[5 .. 6].toByte.float32 / 255,
      z: hex[7 .. 8].toByte.float32 / 255,
      w: hex[1 .. 2].toByte.float32 / 255
    )
  else:
    Color(w: 1)

func color8*(r, g, b, a: uint8): Color =
  Color(
    x: r.float32 / 255,
    y: g.float32 / 255,
    z: b.float32 / 255,
    w: a.float32 / 255
  )

func color8*(r, g, b: uint8): Color =
  Color(
    x: r.float32 / 255,
    y: g.float32 / 255,
    z: b.float32 / 255,
    w: 1
  )

func color8*(r: uint8): Color =
  let c = r.float32 / 255
  Color(
    x: c,
    y: c,
    z: c,
    w: 1
  )

func color8*(): Color =
  Color(w: 1)

func color8*(hex: string): Color =
  case hex.len:
  of 6:
    Color(
      x: hex[0 .. 1].toByte.float32 / 255,
      y: hex[2 .. 3].toByte.float32 / 255,
      z: hex[4 .. 5].toByte.float32 / 255,
      w: 1
    )
  of 7:
    Color(
      x: hex[1 .. 2].toByte.float32 / 255,
      y: hex[3 .. 4].toByte.float32 / 255,
      z: hex[5 .. 6].toByte.float32 / 255,
      w: 1
    )
  of 8:
    Color(
      x: hex[2 .. 3].toByte.float32 / 255,
      y: hex[4 .. 5].toByte.float32 / 255,
      z: hex[6 .. 7].toByte.float32 / 255,
      w: hex[0 .. 1].toByte.float32 / 255
    )
  of 9:
    Color(
      x: hex[3 .. 4].toByte.float32 / 255,
      y: hex[5 .. 6].toByte.float32 / 255,
      z: hex[7 .. 8].toByte.float32 / 255,
      w: hex[1 .. 2].toByte.float32 / 255
    )
  else:
    Color(w: 1)

# Functions

func x8*(self: Color): uint8 =
  (self.x * 255).uint8

func y8*(self: Color): uint8 =
  (self.y * 255).uint8

func z8*(self: Color): uint8 =
  (self.z * 255).uint8

func w8*(self: Color): uint8 =
  (self.w * 255).uint8

func `$`*(self: Color): string =
  &"({self.x}, {self.y}, {self.z}, {self.w})"

# Constants

const red* = color8(255, 0, 0)
const green* = color8(0, 255, 0)
const blue* = color8(0, 0, 255)
const blank* = color8(0, 0, 0, 0)
const black* = color8(0)
const white* = color8(255)

# Palette: https://lospec.com/palette-list/2-bit-grayscale
const bitbit* = static([
  color("000000"), color("676767"), color("b6b6b6"), color("ffffff"),
])

# Palette: https://lospec.com/palette-list/grafxkid-gameboy-pocket-gray
const pocket* = static([
  color("2b2b26"), color("706b66"), color("a89f94"), color("e0dbcd"),
])

# Palette: https://lospec.com/palette-list/nintendo-gameboy-bgb
const gameboy* = static([
  color("081820"), color("346856"), color("88c070"), color("e0f8d0"),
])
