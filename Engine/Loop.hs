module Engine.Loop (display,idle) where

import Control.Monad

import Graphics.Rendering.OpenGL
import Graphics.UI.GLUT

import Game.Core
import Game.Data.BigState
import Game.Data.EventState

display bsRef = do
  clear [ColorBuffer]
  loadIdentity
  get bsRef >>= displayAsteroids . bsWAsteroids
  swapBuffers


idle bsRef = do
  currentTime <- get elapsedTime
  BigState eState wAsteroids stdioBufRef <- get bsRef

  let lastTime = esLastTickTime eState
  let steps = currentTime - lastTime


  updatedWorldAsteroids <- updateAsteroidsFromIO wAsteroids stdioBufRef steps

  BigState newEState updatedWorldAsteroids' _ <- processEvents steps (BigState eState updatedWorldAsteroids stdioBufRef)

  let eState' = newEState {esLastTickTime=currentTime}
  bsRef $= BigState eState' updatedWorldAsteroids' stdioBufRef

  postRedisplay Nothing
