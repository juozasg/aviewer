module Engine.Reshape (reshape) where

import Graphics.Rendering.OpenGL
import Graphics.UI.GLUT

fixedRatio = 1.6 :: Float

keepRatio :: (Integral a) => (a,a) -> (a,a)
keepRatio (w,h)
    | w >= widthFromHeight = (widthFromHeight, h)
    | otherwise = (w, floor(fromIntegral w / fixedRatio))
    where widthFromHeight = floor (fromIntegral h * fixedRatio)

keepSizeRatio :: Size -> Size
keepSizeRatio (Size w h) = uncurry Size $ keepRatio (w,h)

reshape s@(Size w h) = do
  viewport $=(Position 0 0, keepSizeRatio s)
  setProjectionMatrix
  postRedisplay Nothing


setProjectionMatrix = do
  startingMode <- get matrixMode
  matrixMode $= Projection
  loadIdentity
  ortho2D 0 1.6 0 1
  matrixMode $= startingMode

