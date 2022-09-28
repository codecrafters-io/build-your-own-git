# build-your-own-git

Content for the "Build your own Git" challenge

### Setup

Run the following command to download the files required to validate/test solutions.

```sh
$ git clone https://github.com/codecrafters-io/course-definition-tester course_definition_tester
```

### How to submit solutions

- Add your solution to the `solutions` directory, in a folder like this: `solutions/<language>/<stage_slug>/code`. 

- Run the following command to compile diffs and test your solution: 

```sh
# Replace `go` with the language of your solution. 
# The `()` brackets ensure that the current working directory isn't changed.
$ (cd course_definition_tester && make compile && ruby scripts/test_solulutions.rb go
```

- If your solutions passes all tests, open a pull request on GitHub. GitHub actions will run a bunch of automated checks to ensure everything is correct.

Once all tests are passing, tag @rohitpaulk for review. 