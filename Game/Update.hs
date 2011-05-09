module Game.Update (updateAsteroids, runEventState) where

import Data.List

import System.IO
import Control.Monad

import Graphics.Rendering.OpenGL
import Graphics.UI.GLUT

import Game.Data.EventState
import Game.Data.Asteroid
import Game.Events.Dispatch

import Utils.IO

updateAsteroids asteroidsRef stdioBufRef steps = do
  previousContents <- get stdioBufRef
  newContents <- nbGetContents
  let allContents = previousContents ++ newContents
  let (newAsteroids, remainingContent, clear) = parseAsteroidsInput allContents

  previousWorldAsteroids <- if clear then return noWorldAsteroids else get asteroidsRef

  newWorldAsteroids <- mapM randomlyAddAsteroidToWorld newAsteroids

  asteroidsRef $= map (stepWorldAsteroid steps) (previousWorldAsteroids ++ newWorldAsteroids)
  stdioBufRef $= remainingContent


runEventState :: EventState -> IO EventState
runEventState state@(EventState _ _ _ []) = return state
runEventState state = stepEventState state >>= runEventState

stepEventState :: EventState -> IO EventState
stepEventState state@(EventState tt fs sp (event:events)) = do
  let (key, keyState, _, _) = event
  eventDispatchReaction state key keyState
  return $ eventDispatchNewState state key keyState
