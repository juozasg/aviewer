module Engine.Input (keyboardMouse) where

import Game.Core
import Game.Data.BigState
import Game.Data.Asteroid(worldWidth,worldHeight)
import Graphics.UI.GLUT

keyboardMouse bsRef k ks m p = do
  bs <- get bsRef
  let (sizeX,sizeY) = bsScreenSize bs
      Position posX posY = p
      screenX = ((fromIntegral posX) / (fromIntegral sizeX)) * worldWidth
      screenY = (fromIntegral (sizeY - fromIntegral posY)) / (fromIntegral sizeY) * worldHeight
  registerEvent bsRef (k,ks,m,(screenX,screenY))

