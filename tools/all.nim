from osproc import execCmd

proc exec(str: string) =
  var err = execCmd(str)
  if err != 0: quit(err)

when isMainModule:
  exec "nim r tools/fmt.nim"
  exec "nimble test"
