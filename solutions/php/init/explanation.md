The entry point for your Docker implementation is in `app/main.php`.

Study and uncomment the relevant code: 

```php
// Uncomment this to pass the first stage.
$child_pid = pcntl_fork();
if ($child_pid == -1) {
  echo "Error forking!";
}
elseif ($child_pid) {
  // We're in parent.
  pcntl_wait($status);
  echo "Child terminates!";
}
else {
  // Replace current program with calling program.
  echo exec(implode(' ', array_slice($argv, 3)));
}
```

Push your changes to pass the first stage:

```
git add .
git commit -m "pass 1st stage" # any msg
git push origin master
```
