module Game.Core (registerEvent,registerMousePosition,processEvents,displayAsteroids,displayUIElements,updateAsteroidsFromIO) where

import Data.IORef

import Graphics.UI.GLUT

import Game.Data.EventState
import Game.Data.BigState
import Game.Render
import Game.Update

displayAsteroids roids = mapM_ renderAsteroid roids

displayUIElements bigState = do
  let es = bsEventState bigState
      mousePos = esMousePosition es
  maybe (return ()) (drawTrajectory mousePos) (esSpawnPoint es)

drawTrajectory mousePos originPos = renderLine originPos mousePos


registerEvent bsRef event = bsRef $~ (bsModifyEventState (esModifyAvailableEvents (event:)))

registerMousePosition bsRef (x,y) = bsRef $~ (bsModifyEventState (\es -> es {esMousePosition = (x,y)}))
