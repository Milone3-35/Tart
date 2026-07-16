#Widgets

import std/terminal
import std/strutils

proc box(height: int, width: int, y: int, x: int): void =
  setCursorPos(x, y)
  
  echo "╭" & repeat("─", width - 2) & "╮"
  
  for i in 1..<height-1:
    setCursorPos(x, y + i)
    echo "│" & repeat(" ", width - 2) & "│"
  
  if height > 1:
    setCursorPos(x, y + height - 1)
    echo "╰" & repeat("─", width - 2) & "╯"


