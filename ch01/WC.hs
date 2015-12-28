{-- snippet main --}
-- lines beginning with "--" are comments.

main = interact wordCount
    --where wordCount input = show (length (lines input)) ++ "\n"
    --where wordCount input = show . length . lines $ input  ++ "\n"
    where wordCount input = fun input  ++ "\n"
          fun = show . length . lines
{-- /snippet main --}

