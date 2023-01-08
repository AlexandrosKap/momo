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
  ## Returns a byte from a hex string.
  ## If the string is not a valid hex string, 0 is returned.
  try:
    fromHex[uint8](hex)
  except ValueError:
    0

# Constructors and Operators

func color*(r, g, b, a: float32): Color {.inline.} =
  Color(x: r, y: g, z: b, w: a)

func color*(r, g, b: float32): Color {.inline.} =
  Color(x: r, y: g, z: b, w: 1)

func color*(r: float32): Color {.inline.} =
  Color(x: r, y: r, z: r, w: 1)

func color*(): Color {.inline.} =
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

func color8*(r, g, b, a: uint8): Color {.inline.} =
  Color(
    x: r.float32 / 255,
    y: g.float32 / 255,
    z: b.float32 / 255,
    w: a.float32 / 255
  )

func color8*(r, g, b: uint8): Color {.inline.} =
  Color(
    x: r.float32 / 255,
    y: g.float32 / 255,
    z: b.float32 / 255,
    w: 1
  )

func color8*(r: uint8): Color {.inline.} =
  let c = r.float32 / 255
  Color(
    x: c,
    y: c,
    z: c,
    w: 1
  )

# Functions

func x8*(self: Color): uint8 {.inline.} =
  ## Returns x as a byte.
  (self.x * 255).uint8

func y8*(self: Color): uint8 {.inline.} =
  ## Returns y as a byte.
  (self.y * 255).uint8

func z8*(self: Color): uint8 {.inline.} =
  ## Returns z as a byte.
  (self.z * 255).uint8

func w8*(self: Color): uint8 {.inline.} =
  ## Returns w as a byte.
  (self.w * 255).uint8

func `$`*(self: Color): string =
  &"({self.x}, {self.y}, {self.z}, {self.w})"

# Constants

const red* = color(1, 0, 0)
const green* = color(0, 1, 0)
const blue* = color(0, 0, 1)
const blank* = color(0, 0, 0, 0)
const black* = color(0)
const white* = color(1)

# Palette: Colors from Playdate game screenshots.
const playdate* = static([
  color("322f29"), color("dbd7d1")
])

# Palette: https://lospec.com/palette-list/2-bit-grayscale
const bitbit* = static([
  color("000000"), color("676767"), color("b6b6b6"), color("ffffff"),
])

# Palette: https://lospec.com/palette-list/nintendo-gameboy-bgb
const gameboy* = static([
  color("081820"), color("346856"), color("88c070"), color("e0f8d0"),
])
