module Game.Core (displayAsteroids) where

import Graphics.Rendering.OpenGL
import Graphics.UI.GLUT

import Game.Data

displayAsteroids = do
  renderPrimitive Points $ do
    color $ Color3 (0::GLfloat) 0 0
    vertex $ Vertex3 (0.8::GLfloat) 0.5 0