The entry point for your Git implementation is in `src/git/core.clj`.

Study and uncomment the relevant code: 

```clojure
;; Uncomment this block to pass the first stage
(let [command (first args)]
  (case command
    "init"
    (do
      (fs/create-dir ".git")
      (fs/create-dir ".git/objects")
      (fs/create-dir ".git/refs")
      (spit ".git/HEAD" "ref: refs/heads/main\n")
      (println "Initialized git directory"))
    (throw (ex-info (str "Unknown command " command) {}))))
```

Push your changes to pass the first stage:

```
git add .
git commit -m "pass 1st stage" # any msg
git push origin master
```
