module Game.Core (registerEvent,processEvents,displayAsteroids,updateAsteroids) where

import Data.IORef

import Graphics.UI.GLUT

import Game.Data.EventState
import Game.Render
import Game.Update

displayAsteroids roidsRef = get roidsRef >>= mapM_ renderAsteroid

registerEvent esRef event = do
  EventState tt fs sp oldEvents <- get esRef
  esRef $= EventState tt fs sp (event:oldEvents)

processEvents esRef = do
  startingEs <- get esRef
  finalEs <- runEventState startingEs
  esRef $= finalEs

