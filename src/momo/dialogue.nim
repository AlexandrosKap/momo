import tables, strutils, strformat

# TODO: I need to clean this. (copy-pasted lalia)
# TODO: Change the API.

const splitChar = '|'
const variableChar = '$'
const amoonguss = "_"

type
  LineKind* = enum
    Pause,
    Comment,
    Text,
    Label,
    Jump,
    Menu,
    Variable,
    Calculation,
    Procedure,
    Check,

  Line* = ref object
    kind*: LineKind
    content*: string

  DialogueProc* = proc(str: string): string
  DialogueTable*[T] = Table[string, T]

  Dialogue* = ref object
    index: int
    lines: seq[Line]
    labels: DialogueTable[int]
    variables*: DialogueTable[string]
    procedures*: DialogueTable[DialogueProc]

func lineKind*(str: string): LineKind =
  case str:
  of $Pause: Pause
  of $Comment: Comment
  of $Text: Text
  of $Label: Label
  of $Jump: Jump
  of $Menu: Menu
  of $Variable: Variable
  of $Calculation: Calculation
  of $Procedure: Procedure
  of $Check: Check
  else: Pause

func isNameChar*(c: char): bool =
  ## Returns true if the character is a valid variable name character.
  c.isAlphaAscii or c == '_'

func replace*(text: string, token: char, table: Table[string, string]): string =
  ## Returns a string with certain words replaced with words from a table.
  ## Word characters can be alphabetical or an underscore.
  result = ""
  var buffer = ""
  var canAddToResult = true
  if text.len == 0:
    return ""
  for i, c in text:
    if c == token:
      canAddToResult = false
    elif canAddToResult:
      result.add(c)
    elif not c.isNameChar:
      if table.hasKey(buffer):
        result.add(table[buffer])
      result.add(c)
      buffer.setLen(0)
      canAddToResult = true
    else:
      buffer.add(c)
  if buffer.len > 0 or text[^1] == token:
    if table.hasKey(buffer):
      result.add(table[buffer])

func calculate*(text: string): int =
  ## Returns an int by evaluating an expression from a string.
  result = 0
  let args = text.replace(" ", "") & "+0"
  var
    stack = @[0]
    buffer = ""
    lop = ' '
    rop = '+'
    i = 0
  while i < args.len:
    if args[i].isDigit:
      buffer.add(args[i])
    else:
      lop = rop
      rop = args[i]
      var n = 0
      if buffer.len > 0:
        n = buffer.parseInt
      elif rop == '(' and i + 1 < args.len:
        # Find the position of ')'.
        var pcount = 1
        var j = i + 1
        while j < args.len:
          if args[j] == '(': pcount += 1
          elif args[j] == ')': pcount -= 1
          if pcount == 0: break
          j += 1
        # Skip the characters in parentheses.
        n = calculate(args[i + 1 ..< j])
        i = j + 1
        rop = args[i]
      # Calculate expression.
      case lop
      of '+': stack.add(n)
      of '-': stack.add(-n)
      of '*': stack[^1] *= n
      of '/': stack[^1] = stack[^1] div n
      of '%': stack[^1] = stack[^1] mod n
      of '<': stack[^1] = int(stack[^1] < n)
      of '>': stack[^1] = int(stack[^1] > n)
      of '=': stack[^1] = int(stack[^1] == n)
      of '!': stack[^1] = int(stack[^1] != n)
      else: break
      buffer.setLen(0)
    i += 1
  for item in stack: result += item

func newLine*(kind: LineKind, content: string): Line =
  ## Creates a new line.
  Line(kind: kind, content: content)

func newLine*(data: openArray[string]): Line =
  ## Creates a new line from an array.
  if data.len == 2:
    newLine(lineKind(data[0]), data[1])
  else:
    newLine(Pause, "")

func pause*(): Line = newLine(Pause, "")
func comment*(content: string): Line = newLine(Comment, content)
func text*(content: string): Line = newLine(Text, content)
func label*(content: string): Line = newLine(Label, content)
func jump*(content: string): Line = newLine(Jump, content)
func menu*(content: string): Line = newLine(Menu, content)
func variable*(content: string): Line = newLine(Variable, content)
func calculation*(content: string): Line = newLine(Calculation, content)
func procedure*(content: string): Line = newLine(Procedure, content)
func check*(content: string): Line = newLine(Check, content)

func len*(self: Line): int =
  ## Returns the length of the content.
  self.content.len

func split*(self: Line): seq[string] =
  ## Returns the content split by the split character.
  self.content.split(splitChar)

func replace*(self: Line, table: Table[string, string]): string =
  ## Returns the content with certain words replaced with words from a table.
  self.content.replace(variableChar, table)

func `$`*(self: Line): string =
  ## Returns a string from a line.
  &"{self.kind},\"{self.content}\""

func initVariables(): DialogueTable[string] =
  ## Creates the default variables of a dialogue.
  result = DialogueTable[string]()
  result[amoonguss] = "0"

func setIndex(self: Dialogue, value: int) =
  ## Sets the index to a new value.
  if value >= self.lines.len:
    self.index = self.lines.len - 1
  elif value < 0:
    self.index = 0
  else:
    self.index = value

proc refresh(self: Dialogue) =
  ## Reloads the current line until a valid line is found.
  let line = self.lines[self.index]
  case line.kind:
  of Comment, Label:
    self.setIndex(self.index + 1)
    self.refresh()
  of Jump:
    if line.len == 0:
      var i = self.index + 1
      while true:
        if i >= self.lines.len:
          self.setIndex(self.lines.len - 1)
          break
        elif self.lines[i].kind == Label:
          let content = self.lines[i].content
          if content.startsWith(amoonguss) and content in self.labels:
            self.setIndex(self.labels[content])
            break
        i += 1
    elif line.content in self.labels:
      self.setIndex(self.labels[line.content])
    else:
      self.setIndex(self.index + 1)
    self.refresh()
  of Variable:
    let name = if line.len == 0: amoonguss else: line.content
    self.variables[name] = line.content
    self.setIndex(self.index + 1)
    self.refresh()
  of Check:
    if calculate(line.content).intToStr != "":
      self.setIndex(self.index + 1)
    else:
      self.setIndex(self.index + 2)
    self.refresh()
  of Calculation:
    let name = if line.len == 0: amoonguss else: line.content
    if name in self.variables:
      self.variables[name] = calculate(line.content).intToStr
    self.setIndex(self.index + 1)
    self.refresh()
  of Procedure:
    let name = if line.len == 0: amoonguss else: line.content
    let start = line.content.find(' ')
    if start > 0 and start < line.len - 1:
      let procName = line.content[0 ..< start]
      let procText = line.content[start + 1 .. ^1]
      if name in self.variables and procName in self.procedures:
        self.variables[name] = self.procedures[procName](procText)
    elif name in self.variables and line.content in self.procedures:
      self.variables[name] = self.procedures[line.content]("")
    self.setIndex(self.index + 1)
    self.refresh()
  of Pause, Text, Menu:
    discard

proc newDialogue*(lines: varargs[Line]): Dialogue =
  ## Creates a new dialogue.
  result = Dialogue(variables: initVariables())
  for i, line in lines:
    result.lines.add(line)
    if line.kind == Label:
      if line.len == 0:
        result.labels[amoonguss & intToStr(i)] = i
      else:
        result.labels[line.content] = i
  if lines.len > 0 and lines[^1].kind != Pause:
    result.lines.add(pause())
  result.refresh()

func index*(self: Dialogue): int =
  ## Returns the index.
  self.index

func line*(self: Dialogue): Line =
  ## Returns the current line.
  let line = self.lines[self.index]
  Line(
    kind: line.kind,
    content: line.replace(self.variables),
  )

func lines*(self: Dialogue): seq[Line] =
  ## Returns the lines.
  self.lines

func labels*(self: Dialogue): DialogueTable[int] =
  ## Returns the labels.
  self.labels

proc update*(self: Dialogue) =
  ## Updates the dialogue.
  self.setIndex(self.index + 1)
  self.refresh()

proc jump*(self: Dialogue, label: string) =
  ## Changes the current line by using a label.
  if label in self.labels:
    self.setIndex(self.labels[label])
    self.refresh()

proc jumpTo*(self: Dialogue, index: int) =
  ## Changes the current line to a specific line.
  self.setIndex(index)
  self.refresh()

proc jumpToStart*(self: Dialogue) =
  ## Changes the current line to the starting line.
  self.jumpTo(0)

proc jumpToEnd*(self: Dialogue) =
  ## Changes the current line to the ending line.
  self.jumpTo(self.lines.len - 1)

func hasPause*(self: Dialogue): bool =
  ## Returns true if the current line is a stop line.
  self.lines[self.index].kind == Pause

func hasMenu*(self: Dialogue): bool =
  ## Returns true if the current line is a menu line.
  self.lines[self.index].kind == Menu

func choices*(self: Dialogue): seq[string] =
  ## Returns the current choices.
  if self.lines[self.index].kind == Menu:
    self.line.split()
  else:
    @[]

proc choose*(self: Dialogue, choice: int) =
  ## Selects an choice from the current choices.
  var labelCount = 0
  var i = self.index + 1
  # TODO: Fix bug with anonymous labels.
  while true:
    if i >= self.lines.len:
      self.jumpToEnd()
      break
    elif self.lines[i].kind == Label:
      labelCount += 1
      if labelCount == choice + 1:
        let label = self.lines[i].content # TODO
        self.jump(label)
        break
    i += 1

proc reset*(self: Dialogue) =
  ## Resets the dialogue to its original state.
  ## All variables will be deleted and the index is set to the first valid line.
  self.variables = initVariables()
  self.jumpToStart()

proc changeLines*(self: Dialogue, lines: varargs[Line]) =
  ## Changes the lines of the dialogue.
  self.labels.clear()
  self.lines.setLen(0)
  for i, line in lines:
    self.lines.add(line)
    if line.kind == Label:
      if line.len == 0:
        self.labels[amoonguss & intToStr(i)] = i
      else:
        self.labels[line.content] = i
  if lines.len > 0 and lines[^1].kind != Pause:
    self.lines.add(pause())
  self.jumpToStart()

func `$`*(self: Dialogue): string =
  ## Returns a string from a dialogue.
  result = ""
  for i, line in self.lines:
    result.add($line)
    if i != self.lines.len - 1:
      result.add('\n')
