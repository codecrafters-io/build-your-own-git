The entry point for your Git implementation is in `app/main.ts`.

Study and uncomment the relevant code: 

```typescript
// Uncomment this block to pass the first stage
fs.mkdirSync(".git", { recursive: true });
fs.mkdirSync(".git/objects", { recursive: true });
fs.mkdirSync(".git/refs", { recursive: true });
fs.writeFileSync(".git/HEAD", "ref: refs/heads/main\n");
console.log("Initialized git directory");
```

Push your changes to pass the first stage:

```
git add .
git commit -m "pass 1st stage" # any msg
git push origin master
```
