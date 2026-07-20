import winim/lean

proc readKey*(): WORD = 
  var ir: INPUT_RECORD
  let stdin = GetStdHandle(STD_INPUT_HANDLE)
  var read: DWORD 
  
  while true:
    ReadConsoleInputA(stdin, addr ir, 1, addr read)

    if ir.EventType != KeyEvent: continue
    if ir.Event.KeyEvent.bKeyDown == 0: continue

    break
  
  return ir.Event.KeyEvent.wVirtualKeyCode

