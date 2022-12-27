from strformat import `&`
from strutils import fromHex
import private/common

type
  Color* = object
    r*, g*, b*, a*: uint8

  Palette* = seq[Color]
  Grayscale* = seq[uint8]

# Helper Templates

template genOp(op: untyped) =
  func op*(a, b: Color): Color =
    let
      (ar, ag, ab, aa) = (a.r.int32, a.g.int32, a.b.int32, a.a.int32)
      (br, bg, bb, ba) = (b.r.int32, b.g.int32, b.b.int32, b.a.int32)
    Color(
      r: clamp(op(ar, br), 0, 255).uint8,
      g: clamp(op(ag, bg), 0, 255).uint8,
      b: clamp(op(ab, bb), 0, 255).uint8,
      a: clamp(op(aa, ba), 0, 255).uint8
    )

  func op*[T: SomeNumber](a: Color, b: T): Color =
    when T is uint8:
      let
        (ar, ag, ab, aa) = (a.r.int32, a.g.int32, a.b.int32, a.a.int32)
        br = b.int32
      Color(
        r: clamp(op(ar, br), 0, 255).uint8,
        g: clamp(op(ag, br), 0, 255).uint8,
        b: clamp(op(ab, br), 0, 255).uint8,
        a: clamp(op(aa, br), 0, 255).uint8
      )
    else:
      Color(
        r: clamp(op(a.r.T, b), 0, 255).uint8,
        g: clamp(op(a.g.T, b), 0, 255).uint8,
        b: clamp(op(a.b.T, b), 0, 255).uint8,
        a: clamp(op(a.a.T, b), 0, 255).uint8
      )

  func op*[T: SomeNumber](b: T, a: Color): Color =
    when T is uint8:
      let
        (ar, ag, ab, aa) = (a.r.int32, a.g.int32, a.b.int32, a.a.int32)
        br = b.int32
      Color(
        r: clamp(op(ar, br), 0, 255).uint8,
        g: clamp(op(ag, br), 0, 255).uint8,
        b: clamp(op(ab, br), 0, 255).uint8,
        a: clamp(op(aa, br), 0, 255).uint8
      )
    else:
      Color(
        r: clamp(op(a.r.T, b), 0, 255).uint8,
        g: clamp(op(a.g.T, b), 0, 255).uint8,
        b: clamp(op(a.b.T, b), 0, 255).uint8,
        a: clamp(op(a.a.T, b), 0, 255).uint8
      )

template genBoolOp(op: untyped) =
  func op*(a, b: Color): bool =
    op(a.r, b.r) and op(a.g, b.g) and op(a.b, b.b) and op(a.a, b.a)

# Helper Functions

func toByte*(hex: string): uint8 =
  try:
    fromHex[uint8](hex)
  except ValueError:
    0

# Constructors and Operators

func color*(r, g, b, a: uint8): Color =
  Color(r: r, g: g, b: b, a: a)

func color*(r, g, b: uint8): Color =
  Color(r: r, g: g, b: b, a: 255)

func color*(r: uint8): Color =
  Color(r: r, g: r, b: r, a: 255)

func color*(): Color =
  Color(a: 255)

func color*(hex: string): Color =
  case hex.len:
  of 6:
    Color(
      r: hex[0 .. 1].toByte,
      g: hex[2 .. 3].toByte,
      b: hex[4 .. 5].toByte,
      a: 255
    )
  of 7:
    Color(
      r: hex[1 .. 2].toByte,
      g: hex[3 .. 4].toByte,
      b: hex[5 .. 6].toByte,
      a: 255
    )
  of 8:
    Color(
      r: hex[2 .. 3].toByte,
      g: hex[4 .. 5].toByte,
      b: hex[6 .. 7].toByte,
      a: hex[0 .. 1].toByte
    )
  of 9:
    Color(
      r: hex[3 .. 4].toByte,
      g: hex[5 .. 6].toByte,
      b: hex[7 .. 8].toByte,
      a: hex[1 .. 2].toByte
    )
  else:
    Color(a: 255)

func colorf*(r, g, b, a: float32): Color =
  Color(
    r: clamp(r * 255, 0, 255).uint8,
    g: clamp(g * 255, 0, 255).uint8,
    b: clamp(b * 255, 0, 255).uint8,
    a: clamp(a * 255, 0, 255).uint8
  )

func colorf*(r, g, b: float32): Color =
  Color(
    r: clamp(r * 255, 0, 255).uint8,
    g: clamp(g * 255, 0, 255).uint8,
    b: clamp(b * 255, 0, 255).uint8,
    a: 255
  )

func colorf*(r: float32): Color =
  let c = clamp(r * 255, 0, 255).uint8
  Color(r: c, g: c, b: c, a: 255)

func colorf*(): Color =
  Color(a: 255)

genOp(`+`)
genOp(`-`)
genOp(`*`)
genOp(`/`)
genOp(`div`)
genOp(`mod`)

genBoolOp(`==`)
genBoolOp(`!=`)

# Functions

func rf*(self: Color): float32 =
  self.r.float32 / 255

func gf*(self: Color): float32 =
  self.g.float32 / 255

func bf*(self: Color): float32 =
  self.b.float32 / 255

func af*(self: Color): float32 =
  self.a.float32 / 255

func `$`*(self: Color): string =
  &"({self.r}, {self.g}, {self.b}, {self.a})"

# Constants

const red* = color(255, 0, 0)
const green* = color(0, 255, 0)
const blue* = color(0, 0, 255)
const blank* = color(0, 0, 0, 0)
const black* = color(0)
const white* = color(255)

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
