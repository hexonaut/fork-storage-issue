## Fork Storage Issue

Run `forge test` to see the issue. `test_storage` has an assert at the bottom that shouldn't be failing. What's weirder is that simply reading the `bridges` length before forking in the test fixes the issue. My guess is there is some edge case bug with storage persistence across forks with this setup.
