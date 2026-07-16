#Ascii

import std/strutils
import std/enumerate
import std/unicode
import std/terminal

proc parseFile(filepath: string): seq[seq[string]] =
  try:
    let file = open(filepath, fmRead)
    defer: close(file)

    let header = file.readline()
    let headerParts = header.split(' ')

    let 
      signature = headerParts[0]
      height = headerParts[1]
      maxLen = headerParts[3]
      comments = headerParts[5]
      hardblank = signature[5..5]
    
    var charLines: seq[string] = @[]

    for index, line in enumerate(file.lines):
      var mutLine = line
      if index < parseInt(comments):
        continue
      
      while mutLine.endsWith("@"):
        mutLine = mutLine[0 .. ^2]

      if hardblank in mutLine:
        mutLine = mutLine.replace(hardblank, " ")

      charLines.add(mutLine)

    var chars: seq[seq[string]] = @[]
    var char: seq[string] = @[]
    var i: int = 1

    for part in charLines:
      char.add(part)

      if i mod parseInt(height) == 0:
        chars.add(char)
        char = @[]

      i += 1

    return chars

  except IOError:
    echo "ERROR: Failed to read file"

    
proc printAscii*(text: string, fontPath: string, row: int, column: int): void = 
  let font = parseFile(fontPath)

  var codepoints: seq[int] = @[]

  for rune in text.runes:
    codepoints.add(int(rune))
  
  var mutColumn = column

  for i, rune in codepoints:
    var fontIndex = codepoints[i] - 32

    if fontIndex < 0 or fontIndex > font.len:
      continue

    setCursorPos(mutColumn, row)
    
    var tempRow: int = row
    var maxLen: int = 0
  
    for line in font[codepoints[i]]:
      setCursorPos(mutColumn, tempRow)

      echo line
      tempRow += 1

      if line.runeLen > maxLen:
        maxLen = line.runeLen
    
    mutColumn += maxLen + 1



