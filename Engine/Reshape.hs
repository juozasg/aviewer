module Engine.Reshape (reshape) where

import Graphics.Rendering.OpenGL
import Graphics.UI.GLUT

import Game.Data.BigState(bsScreenSize)

fixedRatio = 1.6 :: Float

keepRatio :: (Integral a) => (a,a) -> (a,a)
keepRatio (w,h)
    | w >= widthFromHeight = (widthFromHeight, h)
    | otherwise = (w, floor(fromIntegral w / fixedRatio))
    where widthFromHeight = floor (fromIntegral h * fixedRatio)

keepSizeRatio :: Size -> Size
keepSizeRatio (Size w h) = uncurry Size $ keepRatio (w,h)

reshape bsRef s@(Size w h) = do
  let Size viewX viewY = keepSizeRatio s

  bigState <- get bsRef
  bsRef $= bigState {bsScreenSize = (fromIntegral viewX, fromIntegral viewY)}

  viewport $=(Position 0 0,Size viewX viewY)
  setProjectionMatrix
  postRedisplay Nothing


setProjectionMatrix = do
  startingMode <- get matrixMode
  matrixMode $= Projection
  loadIdentity
  ortho2D 0 1.6 0 1
  matrixMode $= startingMode

