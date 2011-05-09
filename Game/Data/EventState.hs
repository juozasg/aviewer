module Game.Data.EventState where

import Engine.Data
import Graphics.UI.GLUT


data EventState = EventState {
  lastTickTime :: Int,
  isFullScreen :: Bool,
  spawnPoint :: Maybe Position,
  availableEvents :: [InputEvent]
}

blankEventState time = EventState {isFullScreen = False, spawnPoint = Nothing, availableEvents = [], lastTickTime = time}
