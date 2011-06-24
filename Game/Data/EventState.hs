module Game.Data.EventState where

import Engine.Data
import Graphics.UI.GLUT


data EventState = EventState {
  esLastTickTime :: Int,
  esIsFullScreen :: Bool,
  esSpawnPoint :: Maybe (Float,Float),
  esMousePosition :: (Float,Float),
  esAvailableEvents :: [InputEvent]
}

blankEventState time = EventState time False Nothing (0,0) []

esSetFullScreen bool es = es {esIsFullScreen=bool}

esModifyAvailableEvents :: ([InputEvent] -> [InputEvent]) -> EventState -> EventState
esModifyAvailableEvents f es = es {esAvailableEvents = f $ esAvailableEvents es} 