module Game.Render (renderAsteroid,renderLine) where

import Graphics.Rendering.OpenGL
import Graphics.UI.GLUT

import Game.Data.Asteroid

renderAsteroid :: WorldAsteroid -> IO ()
renderAsteroid asteroid = do
  renderPrimitive LineLoop $ asteroidPrimitive $ worldAsteroidToScreen asteroid 

renderLine (sx,sy) (dx,dy) = renderPrimitive LineLoop $ do
  color $ Color3 (1.0::GLfloat) 0.3 0.4
  vertex $ Vertex2 sx sy
  vertex $ Vertex2 dx dy

asteroidPrimitive :: Asteroid -> IO ()
asteroidPrimitive = mapM_ (\(x,y) -> do
  color $ Color3 (1.0::GLfloat) 1.0 1.0
  vertex $ Vertex2 x y)



