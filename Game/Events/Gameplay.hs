module Game.Events.Gameplay(dispatchSpawn, dispatchSpawnClear,dispatchClearAsteroids) where

import Graphics.UI.GLUT

import Engine.Data
import Engine.Controls

import Game.Data.BigState
import Game.Data.EventState
import Game.Data.Asteroid (WorldAsteroid)

dispatchClearAsteroids bigState = return $ bsModifyWAsteroids (\_ -> []) bigState


dispatchSpawn maybeSpawnPoint mousePos bigState = do
  case maybeSpawnPoint of
    Nothing   -> return $ updateSpawnPoint bigState (Just mousePos)
    Just pos  -> return $ spawnAsteroid pos mousePos $ updateSpawnPoint bigState Nothing

dispatchSpawnClear bigState = return $ updateSpawnPoint bigState Nothing


spawnAsteroid sourcePos dirPos bs = bsModifyWAsteroids ((newAsteroid sourcePos dirPos):) bs

newAsteroid s@(sx,sy) d@(dx,dy)= (defaultShape, s, velocity)
  where velocity = ((dx-sx)/300,(dy-sy)/300)
        defaultShape = [(0.01,0.01),(0.01,-0.01),(-0.01,-0.01),(-0.01,0.01)]


updateSpawnPoint bs pos = bsModifyEventState (\es -> es {esSpawnPoint = pos}) bs