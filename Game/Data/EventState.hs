module Game.Data.EventState where

import Engine.Data
import Graphics.UI.GLUT


data EventState = EventState {
  esLastTickTime :: Int,
  esIsFullScreen :: Bool,
  esSpawnPoint :: Maybe Position,
  esAvailableEvents :: [InputEvent]
}

blankEventState time = EventState time False Nothing []

esSetFullScreen bool es = es {esIsFullScreen=bool} 