{-# LANGUAGE OverloadedStrings #-}
module Main where
import Conduit
import Data.Conduit
import Lib


main = do
    putStrLn "Conduit version:"
    runConduitRes
         $ sourceFileBS "/dev/urandom"
         .|
         .| takeC 15
         .| sinkFile "fart.txt"

 
