module Main(main) where

import           PutJSON
import           SimpleJSON

putJValue :: JValue -> IO ()
putJValue = putStrLn . renderJValue

main = print (JObject [("foo",JNumber 1),("bar",JBool False)])
