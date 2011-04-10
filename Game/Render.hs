module Game.Render (renderAsteroid) where

import Graphics.Rendering.OpenGL
import Graphics.UI.GLUT

import Game.Data

renderAsteroid :: Asteroid -> IO ()
renderAsteroid asteroid = do
  renderPrimitive LineLoop $ asteroidPrimitive asteroid


asteroidPrimitive :: Asteroid -> IO ()
asteroidPrimitive = mapM_ (\(x,y) -> do
  color $ Color3 (1.0::GLfloat) 1.0 1.0
  vertex $ Vertex2 x y)



