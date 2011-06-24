module Engine.Input (keyboardMouse, mouseMotion) where

import Game.Core
import Game.Data.BigState
import Game.Data.Asteroid(worldWidth,worldHeight)
import Graphics.UI.GLUT


glPositionToScreenPosition bs p =
  let (sizeX,sizeY) = bsScreenSize bs
      Position posX posY = p
      screenX = ((fromIntegral posX) / (fromIntegral sizeX)) * worldWidth
      screenY = (fromIntegral (sizeY - fromIntegral posY)) / (fromIntegral sizeY) * worldHeight
  in (screenX,screenY)


keyboardMouse bsRef k ks m p = do
  bs <- get bsRef
  let (screenX,screenY) = glPositionToScreenPosition bs p
  registerEvent bsRef (k,ks,m,(screenX,screenY))


mouseMotion bsRef p = do
  bs <- get bsRef
  registerMousePosition bsRef $ glPositionToScreenPosition bs p

