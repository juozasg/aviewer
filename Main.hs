import Data.IORef

import Graphics.Rendering.OpenGL
import Graphics.UI.GLUT

import Engine.Bindings
import Game.Data

as1 = [[(0.01,0.01),(0.2,0.01),(0.2,0.2)],[(0.5,0.5),(0.8,0.5),(1.59,0.99),(0.99,0.99)]] :: Asteroids

main = do
  (progname, _) <- getArgsAndInitialize

  initialDisplayMode $= [DoubleBuffered]
  createWindow "Hello World"
  windowSize $= Size 480 300

  asteroidsRef <- newIORef as1
  isFullScreenRef <- newIORef False

  keyboardMouseCallback $= Just (keyboardMouse isFullScreenRef)
  reshapeCallback $= Just reshape
  idleCallback $= Just (idle asteroidsRef)
  displayCallback $= (display asteroidsRef)

  clearColor $= Color4 0.8 0.8 0.8 0.8
  pointSize $= 10.0
  mainLoop



