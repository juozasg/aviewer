module Engine.Display (display,idle) where

import Graphics.Rendering.OpenGL
import Graphics.UI.GLUT

import Utils.Cube
import Utils.Points
import Game.Core
import Game.Data



display angle position = do
  clear [ColorBuffer]
  loadIdentity
  displayAsteroids

  (x,y) <- get position
  translate $ Vector3 x y 0

  -- preservingMatrix $ do
  a <- get angle
  rotate a $ Vector3 0 0 (1::GLfloat)
  scale 0.7 0.7 (0.7::GLfloat)

  mapM_ ( \(x,y,z) -> preservingMatrix $ do
    color $ Color3 ((x+1.0)/2.0) ((y+1.0)/2.0) ((z+1.0)/2.0)
    translate $ Vector3 x y z
    cube (0.1::GLfloat)
    ) $ points 7


  swapBuffers




idle angle delta = do
  a <- get angle
  d <- get delta
  angle $=! (a + d)
  postRedisplay Nothing



  --
  -- dots = [0,0.5,1,1.5,1.6] :: [GLfloat]
  -- grid = [(x,y) | x <- dots, y <- dots]
  --
  -- simpleDisplayTest = do
  --   renderPrimitive Points $ mapM_ renderDot grid
  --
  -- renderDot (x,y) = do
  --   color $ (Color3 x y 1.0)
  --   vertex $ (Vertex3 x y 0.0)
