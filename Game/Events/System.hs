module Game.Events.System(dispatchToggleFullScreen, dispatchDeath) where

import Graphics.UI.GLUT

import Engine.Data
import Engine.Controls

import Game.Data.BigState
import Game.Data.EventState

dispatchToggleFullScreen :: Bool -> BigState -> IO BigState
dispatchToggleFullScreen isFS bigState = do
  setFullScreen isFS
  return $ bsModifyEventState (esSetFullScreen isFS) bigState

dispatchDeath :: BigState -> IO BigState
dispatchDeath bs = die





