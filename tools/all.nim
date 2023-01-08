from osproc import execCmd

proc exe(str: string) =
  let err = execCmd(str)
  if err != 0:
    quit(err)

when isMainModule:
  exe "nim r tools/fmt.nim"
  exe "nimble test"
