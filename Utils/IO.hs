module Utils.IO (nbGetContents) where

import System.IO
import Control.Monad

nbGetContents :: IO String
nbGetContents = maybeReadChar >>= maybe (return []) appendRemainingAvailableContents
  where appendRemainingAvailableContents c = liftM (c:) nbGetContents


maybeReadChar :: IO (Maybe Char)
maybeReadChar = canRead >>= maybeGetChar
  where
    maybeGetChar False = return Nothing
    maybeGetChar True = getChar >>= return . Just

canRead :: IO Bool
canRead = (hReady stdin >>= return) `catch` const (return False)


