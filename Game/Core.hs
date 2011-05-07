module Game.Core (registerEvent,processEvents,displayAsteroids,updateAsteroids) where

import Data.IORef

import Graphics.UI.GLUT

import Engine.Controls
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

  let EventState tt fs sp events = es
  if empty events
    then return ()
    else

runEventState :: EventState -> IO EventState
runEventState state@(EventState _ _ _ []) = return state
runEventState state = stepEventState state >>= runEventState

stepEventState :: EventState -> IO EventState
stepEventState state@(EventState tt fs sp (event:events)) = do
  let (key, keyState, _, _) = event
  newState <-
    case (fs, key, keyState) of
      (True, (Char 'f'), Down) -> do
        setFullScreen False
        return $ EventState tt False sp events
  return newState

