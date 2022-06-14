The entry point for your Docker implementation is in `app/main.nim`.

Study and uncomment the relevant code: 

```nim
# Uncomment this block to pass the first stage

let command = commandLineParams()[2]
let args = commandLineParams()[3..^1]

let output = execProcess(command, "", args, options={})
echo output
```

Push your changes to pass the first stage:

```
git add .
git commit -m "pass 1st stage" # any msg
git push origin master
```
