module Game.Events.Dispatch(eventDispatch, hasEventsToDispatch) where

import Graphics.UI.GLUT

import Engine.Data
import Engine.Controls

import Game.Data.BigState
import Game.Data.EventState


hasEventsToDispatch :: BigState -> Bool
hasEventsToDispatch bigState = esAvailableEvents (bsEventState bigState) /= []


eventDispatch :: Int -> BigState -> IO BigState
eventDispatch steps bigState = do
  let inputEvent = bsExtractInputEvent bigState
  let (key, keyState, _, _) = inputEvent

  let isFS = esIsFullScreen $ bsEventState bigState

  case (isFS, key, keyState) of
    (False, Char 'f', Down)  -> dispatchToggleFullScreen True bigState
    (True, Char 'f', Down)   -> dispatchToggleFullScreen False bigState
    (_, Char '\ESC', Down)   -> dispatchDeath bigState
    _                        -> dispatchReturn bigState


dispatchToggleFullScreen :: Bool -> BigState -> IO BigState
dispatchToggleFullScreen isFS bigState = do
  setFullScreen isFS
  return $ (modifyBSEventState (esSetFullScreen isFS)) $ bsWithoutFirstInputEvent bigState


dispatchDeath :: BigState -> IO BigState
dispatchDeath bs = die >> dispatchReturn bs

dispatchReturn bs = return $ bsWithoutFirstInputEvent bs

