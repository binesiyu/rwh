{-# LANGUAGE FlexibleInstances    #-}
{-- snippet LANGUAGE --}
{-# LANGUAGE OverlappingInstances #-}
{-# LANGUAGE TypeSynonymInstances #-}
{-- /snippet LANGUAGE --}

import           Control.Arrow (second)
import           SimpleJSON

type JSONError = String

class JSON a where
    toJValue :: a -> JValue
    fromJValue :: JValue -> Either JSONError a

instance JSON JValue where
    toJValue = id
    fromJValue = Right
{-- /snippet class --}

{-- snippet String --}
instance JSON String where
    toJValue               = JString

    fromJValue (JString s) = Right s
    fromJValue _           = Left "not a JSON string"
{-- /snippet String --}

{-- snippet doubleToJValue --}
doubleToJValue :: (Double -> a) -> JValue -> Either JSONError a
doubleToJValue f (JNumber v) = Right (f v)
doubleToJValue _ _ = Left "not a JSON number"

instance JSON Int where
    toJValue = JNumber . realToFrac
    fromJValue = doubleToJValue round

instance JSON Integer where
    toJValue = JNumber . realToFrac
    fromJValue = doubleToJValue round

instance JSON Double where
    toJValue = JNumber
    fromJValue = doubleToJValue id
{-- /snippet doubleToJValue --}

{-- snippet Bool --}
instance JSON Bool where
    toJValue = JBool
    fromJValue (JBool b) = Right b
    fromJValue _ = Left "not a JSON boolean"
{-- /snippet Bool --}

mapEithers :: (a -> Either b c) -> [a] -> Either b [c]
mapEithers f (x:xs) = case mapEithers f xs of
                        Left err -> Left err
                        Right ys -> case f x of
                                      Left err -> Left err
                                      Right y -> Right (y:ys)
mapEithers _ _ = Right []

{-- snippet array --}
instance (JSON a) => JSON [a] where
    toJValue = JArray . map toJValue
    fromJValue (JArray a) = mapEithers fromJValue a
    fromJValue _ = Left "is not Array"
{-- /snippet array --}

{-- snippet object --}
instance (JSON a) => JSON [(String, a)] where
    toJValue = JObject . map (\(key,value) -> (key,toJValue value))
    fromJValue (JObject o) = mapEithers f o
               where f (key,value) = case fromJValue value of
                                         Left err -> Left err
                                         Right y-> Right (key,y)
    fromJValue _ = Left "is not Object"
{-- /snippet object --}
