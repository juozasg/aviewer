module Engine.Loop (display,idle) where

import Graphics.Rendering.OpenGL
import Graphics.UI.GLUT

import Game.Core

display asteroidsRef = do
  clear [ColorBuffer]
  loadIdentity
  displayAsteroids asteroidsRef
  swapBuffers


idle asteroidsRef = do
  updateAsteroids asteroidsRef
  -- a <- get angle
  -- d <- get delta
  -- angle $=! (a + d)
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