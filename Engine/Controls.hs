module Engine.Controls where

import System.Exit

import Graphics.Rendering.OpenGL
import Graphics.UI.GLUT

die = do
  Just w <- get currentWindow
  destroyWindow w
  exitSuccess

setFullScreen False = do
  windowSize $= Size 480 300

setFullScreen True = do
  fullScreen

toggleFullScreen fs = do
  currentFS <- get fs
  setFullScreen currentFS
  fs $= (not currentFS)