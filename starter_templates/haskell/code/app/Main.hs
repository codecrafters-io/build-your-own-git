{-# LANGUAGE BlockArguments #-}
{-# LANGUAGE OverloadedStrings #-}
{-# OPTIONS_GHC -Wno-unused-top-binds #-}

module Main (main) where

import System.Directory (createDirectoryIfMissing)
import System.FilePath ((</>))
import System.IO (IOMode (WriteMode), hPutStrLn, withFile)

main :: IO ()
main = do
    -- You can use print statements as follows for debugging, they'll be visible when running tests.
    putStrLn "Logs from your program will appear here"

    -- Uncomment this block to pass first stage
    -- let createParents = True
    -- createDirectoryIfMissing createParents ".git"
    -- createDirectoryIfMissing createParents (".git" </> "objects")
    -- createDirectoryIfMissing createParents (".git" </> "refs")
    -- withFile (".git" </> "HEAD") WriteMode $ \f -> hPutStrLn f "ref: refs/heads/main"
    -- putStrLn $ "Initialized git directory"
