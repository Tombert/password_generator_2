{-# LANGUAGE OverloadedStrings #-}
module Main where
import Conduit
import System.Environment
import Data.Conduit
import Data.ByteString as BS
import Data.String
import Data.Text as T
import Lib

toIntegers :: ByteString -> [Int]
toIntegers = (Prelude.map fromIntegral) . BS.unpack 

realAlphabet :: ByteString
realAlphabet = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!@#$%^&*()_+{}|\\:;'\"<>,./?"


main = do
    args <- getArgs
    let len = read (args !! 0) :: Int
    let l = BS.length realAlphabet
    runConduitRes
         $ sourceFileBS "/dev/urandom"
         .| mapC toIntegers
         .| concatC
         .| mapC (`mod` l)
         .| mapC (BS.index realAlphabet)
         .| mapC (BS.pack . (:[]))
         .| takeCE 15
         .| stdoutC
    BS.putStrLn ""
    return ()
