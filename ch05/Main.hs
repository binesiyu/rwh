module Main(main) where

import qualified PrettifyJSON as PJ
import qualified PutJSON      as P
import           SimpleJSON

putJValue :: JValue -> IO ()
putJValue = putStrLn . P.renderJValue

main = print (JObject [("foo",JNumber 1),("bar",JBool False)])
