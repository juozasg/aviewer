module Game.Data.Main where

import Graphics.Rendering.OpenGL
import Graphics.UI.GLUT

import Game.Data.Asteroid
import Game.Data.EventState

data BigState = BigState {
  eventState :: EventState,
  asteroids :: Asteroids,
  stdioBufRef :: IORef String
}

