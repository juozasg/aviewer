module Game.Render (renderAsteroid) where

import Graphics.Rendering.OpenGL
import Graphics.UI.GLUT

import Game.Data

renderAsteroid :: Asteroid -> IO ()
renderAsteroid asteroid = do
  renderPrimitive LineLoop $ asteroidPrimitive asteroid


asteroidPrimitive :: Asteroid -> IO ()
asteroidPrimitive = mapM_ asteroidPoint


asteroidPoint :: (Float,Float) -> IO ()
asteroidPoint (x,y) = do
  color $ Color3 (0::GLfloat) 0 0
  vertex $ Vertex2 x (y::GLfloat)