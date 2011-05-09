module Engine.Loop (display,idle) where

import Graphics.Rendering.OpenGL
import Graphics.UI.GLUT

import Game.Core
import Game.Data.EventState

display asteroidsRef = do
  clear [ColorBuffer]
  loadIdentity
  displayAsteroids asteroidsRef
  swapBuffers


idle asteroidsRef stdioBufRef esRef = do
  EventState lastTime fs sp oldEvents <- get esRef
  currentTime <- get elapsedTime
  esRef $= EventState currentTime fs sp oldEvents

  let steps = currentTime - lastTime
  updateAsteroids asteroidsRef stdioBufRef steps

  processEvents esRef

  postRedisplay Nothing
