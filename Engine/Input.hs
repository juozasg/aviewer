module Engine.Input (keyboardMouse) where

import Game.Core

keyboardMouse esRef k ks m p = registerEvent esRef (k,ks,m,p)
