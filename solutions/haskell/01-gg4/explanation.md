The entry point for your Git implementation is in `app/Main.hs`.

Study and uncomment the relevant code: 

```haskell
-- Uncomment this block to pass first stage
let createParents = True
createDirectoryIfMissing createParents ".git"
createDirectoryIfMissing createParents (".git" </> "objects")
createDirectoryIfMissing createParents (".git" </> "refs")
withFile (".git" </> "HEAD") WriteMode $ \f -> hPutStrLn f "ref: refs/heads/main"
putStrLn $ "Initialized git directory"
```

Push your changes to pass the first stage:

```
git add .
git commit -m "pass 1st stage" # any msg
git push origin master
```
