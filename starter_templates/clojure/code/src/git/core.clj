(ns git.core
  (:require
   [babashka.fs :as fs])
  (:gen-class))

(defn -main [& args]
  ;; You can use print statements as follows for debugging, they'll be visible when running tests.
  (println "Logs from your program will appear here!")

  ;; Uncomment this block to pass the first stage
  ;; (let [command (first args)]
  ;;   (case command
  ;;     "init"
  ;;     (do
  ;;       (fs/create-dir ".git")
  ;;       (fs/create-dir ".git/objects")
  ;;       (fs/create-dir ".git/refs")
  ;;       (spit ".git/HEAD" "ref: refs/heads/main\n")
  ;;       (println "Initialized git directory"))
  ;;     (throw (ex-info (str "Unknown command " command) {}))))
  )
