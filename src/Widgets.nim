#Widgets

import std/terminal
import Utils
import winim/lean
import std/sequtils
import std/strutils


proc renderSurvey(choices: seq[string], row: int, col: int, selected: int): void = 
  var mutRow: int = row
  var mutSelected: int = selected

  if selected > choices.len() or selected < 0:
    mutSelected = 0
  
  let maxLen: int = choices.mapIt(it.len + 2).max()

  for index, choice in choices:
    if index == selected:
      setCursorPos(col, mutRow)
      
      echo repeat(" ", maxLen)

      setCursorPos(col, mutRow)
      echo "> ", choice
    else:
      setCursorPos(col, mutRow)

      echo repeat(" ", maxLen)

      setCursorPos(col, mutRow)
      echo choice 

    mutRow += 1


proc survey(question: string, choices: seq[string], row: int, col: int): string =
  setCursorPos(col, row)
  echo question 

  var mutRow = row 
  mutRow += 1
  
  var mutCol = col
  mutCol += 1
  
  var selected: int = 0

  renderSurvey(choices, mutRow, mutCol, selected)

  while true:
    var key: WORD = readKey()

    case key:
      of 38:    #UP
        if (selected - 1) >= 0:
          selected -= 1
          
          renderSurvey(choices, mutRow, mutCol, selected)

      of 40:    #DOWN
        if (selected + 1) < choices.len():
          selected += 1
        
          renderSurvey(choices, mutRow, mutCol, selected)

      of 13:    #ENTER
        return choices[selected]

      else:
        continue


        
