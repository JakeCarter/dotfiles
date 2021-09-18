hs.loadSpoon("ReloadConfiguration")
spoon.ReloadConfiguration:start()

local hyperex = require('hyperex')
local rightCmd = hyperex.new('rightcmd')

rightCmd:bind('w'):to(function()
  local padding = 10
  local win = hs.window.focusedWindow()
  local f = win:frame()
  
  local screen = win:screen()
  local screenFrame = screen:frame()
  
  
  f.x = screenFrame.x + padding
  f.y = screenFrame.y + padding
  f.w = screenFrame.w - (padding * 2)
  f.h = screenFrame.h - (padding * 2)
  
  win:setFrame(f)
end)

rightCmd:bind('v'):to(function()
    hs.eventtap.keyStrokes(hs.pasteboard.getContents())
end)

hs.grid.setGrid('4x4')
hs.grid.HINTS = {
    { 'f7', 'f8', 'f9', 'f10' },
    { '7', '8', '9', '0' },
    { 'u', 'i', 'o', 'p' },
    { 'j', 'k', 'l', ';' },
    { 'm', ',', '.', '/' }
}
hs.grid.ui.showExtraKeys = false
hs.grid.ui.textSize = 100
hs.grid.ui.cellStrokeWidth = 1
hs.grid.ui.highlightStrokeWidth = 3
hs.grid.ui.fontName = 'Helvetica'
hs.grid.ui.highlightColor = { 0.968627451, 0.31372549, 0.619607843, 0.8 }
hs.grid.ui.cyclingHighlightColor = { 0.968627451, 0.31372549, 0.619607843, 0.5 }
hs.grid.ui.highlightStrokeColor = { 0.0, 0.0, 0.0, 1 }
hs.grid.ui.cyclingHighlightStrokeColor = { 0.0, 0.0, 0.0, 1 }

rightCmd:bind('e'):to(function()
    hs.grid.show()
end)
rightCmd:bind('m'):to(function()
    hs.grid.snap(hs.window.frontmostWindow())
end)
