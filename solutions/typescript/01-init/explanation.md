The entry point for your Git implementation is in `app/main.ts`.

Study and uncomment the relevant code: 

```typescript
// Uncomment this block to pass the first stage

Deno.mkdirSync(".git", { recursive: true });
Deno.mkdirSync(".git/objects", { recursive: true });
Deno.mkdirSync(".git/refs", { recursive: true });
Deno.writeTextFileSync(".git/HEAD", "ref: refs/heads/main\n");
console.log("Initialized git directory");
```

Push your changes to pass the first stage:

```
git add .
git commit -m "pass 1st stage" # any msg
git push origin master
```
