module Game.Data.BigState where

import Engine.Data

import Data.IORef

import Graphics.Rendering.OpenGL
import Graphics.UI.GLUT

import Game.Data.Asteroid
import Game.Data.EventState

data BigState = BigState {
  bsEventState :: EventState,
  bsWAsteroids :: WorldAsteroids,
  bsStdioBufRef :: IORef String,
  bsScreenSize :: (Int, Int)
}

bsModifyEventState :: (EventState -> EventState) -> BigState -> BigState
bsModifyEventState f bs = bs {bsEventState = f $ bsEventState bs}

bsModifyWAsteroids :: (WorldAsteroids -> WorldAsteroids) -> BigState -> BigState
bsModifyWAsteroids f bs = bs {bsWAsteroids = f $ bsWAsteroids bs}

bsExtractInputEvent :: BigState -> InputEvent
bsExtractInputEvent bs = head $ esAvailableEvents $ bsEventState bs

bsWithoutFirstInputEvent :: BigState -> BigState
bsWithoutFirstInputEvent bs = bsModifyEventState (\es -> es {esAvailableEvents = (tail $ esAvailableEvents es)}) bs

