module Game.Core (registerEvent,processEvents,displayAsteroids,updateAsteroidsFromIO) where

import Data.IORef

import Graphics.UI.GLUT

import Game.Data.EventState
import Game.Data.BigState
import Game.Render
import Game.Update

displayAsteroids roids = mapM_ renderAsteroid roids

registerEvent bsRef event = bsRef $~ (bsModifyEventState (appendEvent event))
  where appendEvent e (EventState tt fs sp oldEvents) = EventState tt fs sp (e:oldEvents)

