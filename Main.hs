import Data.IORef

import Graphics.Rendering.OpenGL
import Graphics.UI.GLUT

import Engine.Bindings

main = do
  (progname, _) <- getArgsAndInitialize

  initialDisplayMode $= [DoubleBuffered]
  createWindow "Hello World"
  windowSize $= Size 480 300

  angle <- newIORef (0.0::GLfloat)
  delta <- newIORef (0.1::GLfloat)
  position <- newIORef (0.8::GLfloat, 0.5)
  isFullScreen <- newIORef False

  keyboardMouseCallback $= Just (keyboardMouse isFullScreen delta position)
  reshapeCallback $= Just reshape
  idleCallback $= Just (idle angle delta)
  displayCallback $= (display angle position)

  clearColor $= Color4 0.8 0.8 0.8 0.8
  pointSize $= 10.0
  mainLoop



