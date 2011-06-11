module Game.Update (updateAsteroidsFromIO, processEvents) where

import Data.List
import Data.IORef

import System.IO
import Control.Monad

import Graphics.Rendering.OpenGL
import Graphics.UI.GLUT

import Game.Data.BigState
import Game.Data.EventState
import Game.Data.Asteroid

import Game.Events.Dispatch

import Utils.IO

updateAsteroidsFromIO :: WorldAsteroids -> (IORef String) -> Int -> IO WorldAsteroids
updateAsteroidsFromIO wAsteroids stdioBufRef steps = do
  previousContents <- get stdioBufRef
  newContents <- nbGetContents
  let allContents = previousContents ++ newContents
  let (newAsteroids, remainingContent, clear) = parseAsteroidsInput allContents
  stdioBufRef $= remainingContent

  let previousWorldAsteroids = if clear then noWorldAsteroids else wAsteroids
  newWorldAsteroids <- mapM randomlyAddAsteroidToWorld newAsteroids

  return $ map (stepWorldAsteroid steps) (previousWorldAsteroids ++ newWorldAsteroids)


processEvents :: Int -> BigState -> IO BigState
processEvents steps bigState = 
  if hasEventsToDispatch bigState
    then (eventDispatch steps bigState) >>= (processEvents steps)
    else return bigState
  
