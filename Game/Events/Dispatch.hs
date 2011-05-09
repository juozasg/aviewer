module Game.Events.Dispatch where

import Graphics.UI.GLUT

import Engine.Data
import Engine.Controls
import Game.Data.EventState


eventDispatchReaction :: EventState -> Key -> KeyState -> IO ()
eventDispatchReaction (EventState _ fs _ _) key keyState =
  case (fs, key, keyState) of
    (False, Char 'f', Down)  -> setFullScreen True
    (True, Char 'f', Down)   -> setFullScreen False
    (_, Char '\ESC', Down)   -> die
    (_,_,_)                  -> return ()

eventDispatchNewState :: EventState -> Key -> KeyState -> EventState
eventDispatchNewState (EventState tt fs sp (e:es)) key keyState =
  case (fs, key, keyState) of
    (False, Char 'f', Down) -> EventState tt True sp es
    (True, Char 'f', Down)  -> EventState tt True sp es
    (_,_,_)                 -> EventState tt fs sp es
