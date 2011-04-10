import Data.IORef

import Graphics.Rendering.OpenGL
import Graphics.UI.GLUT

import Engine.Bindings
import Game.Data

as1 = [[(0.01,0.01),(0.2,0.01),(0.2,0.2)],[(0.5,0.5),(0.8,0.5),(1.59,0.99),(0.99,0.99)]] :: Asteroids


setLineSmooth :: IO ()
setLineSmooth = do
  blend $= Enabled
  lineSmooth $= Enabled
  blendFunc $= (SrcAlpha,OneMinusSrcAlpha)
  hint LineSmooth $= Nicest

main = do
  (progname, _) <- getArgsAndInitialize

  initialDisplayMode $= [DoubleBuffered]
  createWindow "Hello World"
  windowSize $= Size 480 300

  setLineSmooth

  asteroidsRef <- newIORef as1
  isFullScreenRef <- newIORef False

  keyboardMouseCallback $= Just (keyboardMouse isFullScreenRef)
  reshapeCallback $= Just reshape
  idleCallback $= Just (idle asteroidsRef)
  displayCallback $= (display asteroidsRef)

  clearColor $= Color4 0.1 0.1 0.1 1.0
  mainLoop



