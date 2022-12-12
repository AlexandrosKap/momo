from os import walkDirRec
from osproc import execCmd

const command = "nimpretty "

for file in walkDirRec("."):
  if file.len >= 4 and file[^4 .. ^1] == ".nim":
    let err = execCmd(command & file)
    if err != 0: echo "Failed!"
