module Game.Events.Dispatch(eventDispatch, hasEventsToDispatch) where

import Graphics.UI.GLUT

import Engine.Data
import Engine.Controls

import Game.Data.BigState
import Game.Data.EventState

import Game.Events.Gameplay

hasEventsToDispatch :: BigState -> Bool
hasEventsToDispatch bigState = esAvailableEvents (bsEventState bigState) /= []


eventDispatch :: Int -> BigState -> IO BigState
eventDispatch steps bigState = do
  let inputEvent = bsExtractInputEvent bigState
  let (key, keyState, _, mousePos) = inputEvent

  let isFS = esIsFullScreen $ bsEventState bigState
  let maybeSpawnPoint = esSpawnPoint $ bsEventState bigState

  let newBigState = bsWithoutFirstInputEvent bigState
  case (isFS, key, keyState) of
    (False, Char 'f', Down)   -> dispatchToggleFullScreen True newBigState
    (True, Char 'f', Down)    -> dispatchToggleFullScreen False newBigState
    (_, Char '\ESC', Down)    -> dispatchDeath newBigState

    (_, Char 'c', Down)    -> dispatchClearAsteroids newBigState

    (_, MouseButton LeftButton, Down)     -> dispatchSpawn maybeSpawnPoint mousePos newBigState
    (_, MouseButton RightButton, Down)    -> dispatchSpawnClear newBigState

    _ -> return newBigState


dispatchToggleFullScreen :: Bool -> BigState -> IO BigState
dispatchToggleFullScreen isFS bigState = do
  setFullScreen isFS
  return $ bsModifyEventState (esSetFullScreen isFS) bigState

dispatchDeath :: BigState -> IO BigState
dispatchDeath bs = die








