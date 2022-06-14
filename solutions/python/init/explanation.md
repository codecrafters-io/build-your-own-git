The entry point for your Git implementation is in `app/main.py`.

Study and uncomment the relevant code: 

```python
# Uncomment this block to pass the first stage

command = sys.argv[1]
if command == "init":
    os.mkdir(".git")
    os.mkdir(".git/objects")
    os.mkdir(".git/refs")
    with open(".git/HEAD", "w") as f:
        f.write("ref: refs/heads/master\n")
    print("Initialized git directory")
else:
    raise RuntimeError(f"Unknown command #{command}")
```

Push your changes to pass the first stage:

```
git add .
git commit -m "pass 1st stage" # any msg
git push origin master
```
