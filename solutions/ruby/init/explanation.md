The entry point for your Git implementation is in `app/main.rb`.

Study and uncomment the relevant code: 

```ruby
# Uncomment this block to pass the first stage

command = ARGV[0]
case command
when "init"
  Dir.mkdir(".git")
  Dir.mkdir(".git/objects")
  Dir.mkdir(".git/refs")
  File.write(".git/HEAD", "ref: refs/heads/master\n")
  puts "Initialized git directory"
else
  raise RuntimeError.new("Unknown command #{command}")
end
```

Push your changes to pass the first stage:

```
git add .
git commit -m "pass 1st stage" # any msg
git push origin master
```
