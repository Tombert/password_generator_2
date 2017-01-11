{-# LANGUAGE ExtendedDefaultRules #-}
module Main where
import Conduit
import qualified Data.Conduit.List as CL
import Lib

main :: IO ()
main = do
  putStrLn "Testing Stuff"
  runConduit
             $ yieldMany [1..]
            .| takeC 5
  return ()

