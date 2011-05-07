module Game.Data.EventState where

import Engine.Controls
import Game.Data.All

data EventsState = EventsState {
  lastTickTime :: Int,
  isFullScreen :: Bool,
  spawnPoint :: Maybe Position,
  availableEvents :: [InputEvent]
}

blankEventState time = EventState {isFullScreen = False, spawnPoint = Nothing, availableEvents = [], lastTickTime = time}

-- esRefGet esRef field = do
--   es <- get esRef
--   return (esGet field)
-- 
-- esRefSet esRef field val = do
--   es <- get esRef
--   esRef $= (esSet es field val)
--   return ()
-- 
-- esRefApply esRef field func = do
--   es <- get esRef
--   esRef $= (esApply es field val)
--   return ()
-- 
-- 
-- esGet es field
-- esSet es field val
-- esApply es field func