module Engine.Controls (keyboardMouse) where

import System.Exit


import Graphics.Rendering.OpenGL
import Graphics.UI.GLUT
-- 
-- keyboardAct ad p (Char ' ') Down = do
--   ad' <- get ad
--   ad $= -ad'
-- 
-- keyboardAct ad p (Char '+') Down = do
--   ad' <- get ad
--   ad $= ad'*2
-- 
-- keyboardAct ad p (Char '-') Down = do
--   ad' <- get ad
--   ad $= ad'/2
-- 
-- keyboardAct ad p (SpecialKey KeyLeft) Down = do
--   (x,y) <- get p
--   p $= (x-0.1,y)
-- 
-- keyboardAct ad p (SpecialKey KeyRight) Down = do
--   (x,y) <- get p
--   p $= (x+0.1,y)
-- 
-- keyboardAct ad p (SpecialKey KeyUp) Down = do
--   (x,y) <- get p
--   p $= (x,y+0.1)
-- 
-- keyboardAct ad p (SpecialKey KeyDown) Down = do
--   (x,y) <- get p
--   p $= (x,y-0.1)
-- 
-- keyboardAct _ _ _ _ = return ()


die = do
  Just w <- get currentWindow
  destroyWindow w
  exitSuccess

setFS False = do
  windowSize $= Size 480 300

setFS True = do
  fullScreen

toggleFullScreen fs = do
  currentFS <- get fs
  setFS currentFS
  fs $= (not currentFS)


keyboardMouse fs (Char '\ESC') Down modifiers position = do
  die

keyboardMouse fs (Char 'f') Down modifiers position = do
  toggleFullScreen fs

keyboardMouse _ _ _ _ _ = return ()
-- 
-- keyboardMouse fs key state modifiers position = do
--   keyboardAct adelta pos key state