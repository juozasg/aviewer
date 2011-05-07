module Engine.Controls (keyboardMouse) where

import System.Exit

import Graphics.Rendering.OpenGL
import Graphics.UI.GLUT

import Game.Core

type InputEvent = (Key, KeyState, Modifiers, Position)

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
  setFS currentFS
  fs $= (not currentFS)

-- 
-- keyboardMouse fs (Char '\ESC') Down modifiers position = do
--   die
-- 
-- keyboardMouse fs (Char 'f') Down modifiers position = do
--   toggleFullScreen fs

keyboardMouse esRef k ks m p = registerEvent esRef (k,ks,m,p)
