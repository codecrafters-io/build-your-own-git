{-# LANGUAGE BlockArguments #-}
{-# LANGUAGE OverloadedStrings #-}
{-# OPTIONS_GHC -Wno-unused-top-binds #-}

module Main (main) where

import System.Directory (createDirectoryIfMissing)
import System.FilePath ((</>))
import System.IO (IOMode (WriteMode), hPutStrLn, withFile, hSetBuffering, stdout, stderr, BufferMode (NoBuffering))

main :: IO ()
main = do
    -- Disable output buffering
    hSetBuffering stdout NoBuffering
    hSetBuffering stderr NoBuffering

    let createParents = True
    createDirectoryIfMissing createParents ".git"
    createDirectoryIfMissing createParents (".git" </> "objects")
    createDirectoryIfMissing createParents (".git" </> "refs")
    withFile (".git" </> "HEAD") WriteMode $ \f -> hPutStrLn f "ref: refs/heads/main"
    putStrLn $ "Initialized git directory"
