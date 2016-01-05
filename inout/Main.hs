import           Data.Char

main = putStrLn "hello,world!"

main1 = do
      putStrLn "Hello,what's your name?"
      name <- getLine
      putStrLn ("Hey " ++ name ++ ",you rock!")

main2 = do
     putStrLn "What's your first name?"
     firstname <- getLine
     putStrLn "what's your last name?"
     lastname <- getLine
     let bigFirstName = map toUpper firstname
         bigLastName = map toUpper lastname
     putStrLn $ "Hey " ++ bigFirstName ++ " " ++ bigLastName ++ ",how are you?"
