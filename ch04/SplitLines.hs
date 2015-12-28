module SplitLines(splitLines) where

splitLines :: String -> [String]


splitLines [] = []
splitLines cs =
        let (pre,suf) = break isLineTerminator cs
        in pre : case suf of
            ('\r':'\n':reset) -> splitLines reset
            ('\r':reset) -> splitLines reset
            ('\n':reset) -> splitLines reset
            _ -> []

isLineTerminator c = c=='\r' || c == '\n'
