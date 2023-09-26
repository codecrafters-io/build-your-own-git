import Test.HUnit

-- Define your test cases here
testAddition :: Test
testAddition = "Addition Test" ~: do
    assertEqual "1 + 1 should be 2" (1 + 1) 2
    assertEqual "2 + 3 should be 5" (2 + 3) 5

testSubtraction :: Test
testSubtraction = "Subtraction Test" ~: do
    assertEqual "5 - 3 should be 2" (5 - 3) 2
    assertEqual "10 - 7 should be 3" (10 - 7) 3

-- Add more test cases as needed

-- Define the main test suite
main :: IO ()
main = do
    counts <- runTestTT $ TestList
        [ testAddition
        , testSubtraction
        -- Add more test cases here
        ]
    if errors counts + failures counts == 0
        then putStrLn "All tests passed!"
        else putStrLn "Some tests failed!"

