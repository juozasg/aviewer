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
  bsStdioBufRef :: IORef String
}

modifyBSEventState :: (EventState -> EventState) -> BigState -> BigState
modifyBSEventState f bs = bs {bsEventState = f $ bsEventState bs}

bsExtractInputEvent :: BigState -> InputEvent
bsExtractInputEvent bs = head $ esAvailableEvents $ bsEventState bs

bsWithoutFirstInputEvent :: BigState -> BigState
bsWithoutFirstInputEvent bs = modifyBSEventState (\es -> es {esAvailableEvents = (tail $ esAvailableEvents es)}) bs